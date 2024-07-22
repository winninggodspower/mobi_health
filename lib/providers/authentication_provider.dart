import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as developer;

class AuthenticationProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  Map<String, dynamic>? _userInfo;

  // Initialize the AuthProvider
  AuthenticationProvider() {
    _auth.authStateChanges().listen((user) async {
      _user = user;
      developer.log(user!.displayName as String );
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
        Map? userInfo = userDoc.data() as Map<String, dynamic>?;
        developer.log(userInfo.toString());

        String userType = (userInfo?['userType'] ?? false) == 'hospital' ? 'hospital' : 'patient';

        if (_userInfo?['userType'] == 'hospital' || _userInfo?['userType'] == 'patient') {
          DocumentSnapshot detailDoc = await _firestore.collection(userType).doc(uid).get();
          
          if (detailDoc.exists) {
            Map<String, dynamic>? detailInfo = detailDoc.data() as Map<String, dynamic>?;
            if (detailInfo != null) {
              developer.log(detailInfo.toString());
              userInfo?.addAll(detailInfo);
            }
          }

        }
        _userInfo = userInfo as Map<String, dynamic>;
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
