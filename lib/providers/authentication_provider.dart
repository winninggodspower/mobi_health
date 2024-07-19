import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  Map<String, dynamic>? _userInfo;

  // Initialize the AuthProvider
  AuthenticationProvider() {
    _auth.authStateChanges().listen((user) async {
      _user = user;
      if (user != null) {
        await _fetchUserInformation(user.uid);
      }
      notifyListeners();
    });
  }

  User? get user => _user;
  Map<String, dynamic>? get userInfo => _userInfo;
  bool get isLoggedIn => _user != null;

  Future<void> signInWithPhoneAndPassword(String phone, String password, BuildContext context) async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents dialog from being dismissed by tapping outside
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: '$phone@example.com',
        password: password,
      );

      if (!context.mounted) return;

      // Check if user credential is not null and navigate to dashboard
      if (userCredential.user != null) {
        _user = userCredential.user;
        await _fetchUserInformation(_user!.uid);
        notifyListeners();

        // Dismiss the dialog and show an error message
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        // Dismiss the dialog and show an error message
        Navigator.pop(context);
        _showSnackBar(context, 'Failed to sign in');
      }
    } catch (e) {
        print(e);

        // Dismiss the dialog and show an error message
        Navigator.pop(context);
      _showSnackBar(context, 'Failed to sign in');
    }
  }

  // Method to handle user sign-out (you'll need to implement this)
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      _user = null;
      _userInfo = null;
      notifyListeners(); // Notify listeners of changes
    } catch (e) {
      print('Error signing out: $e');
    }
  }

   Future<void> _fetchUserInformation(String uid) async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        _userInfo = userDoc.data() as Map<String, dynamic>?;
      } else {
        _userInfo = null;
      }
    } catch (e) {
      print('Error fetching user information: $e');
      _userInfo = null;
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
  
}
