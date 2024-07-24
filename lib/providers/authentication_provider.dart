import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as developer;

import 'package:workmanager/workmanager.dart';

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
      Workmanager().cancelAll();
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

        String userType = (userInfo?['userType'] ?? false) == 'hospital' ? 'hospital' : 'patient';

        if (userType == 'hospital' || userType == 'patient') {
          DocumentSnapshot detailDoc = await _firestore.collection(userType).doc(uid).get();
          
          if (detailDoc.exists) {
            Map<String, dynamic>? detailInfo = detailDoc.data() as Map<String, dynamic>?;
            if (detailInfo != null) {
              developer.log(detailInfo.toString());
              userInfo?.addAll(detailInfo);
            }
          }

        }

        developer.log(userInfo.toString());
        _userInfo = userInfo as Map<String, dynamic>;
      } else {
        _userInfo = null;
      }
    } catch (e) {
      print('Error fetching user information: $e');
      _userInfo = null;
    }
  }

  Future<Map?> getUserHospital()async{
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('hospital')
          .where('name', isEqualTo: _userInfo?['hospital'])
          .get();
      
      if (querySnapshot.docs.isNotEmpty) {
        // Get the first document
        DocumentSnapshot doc = querySnapshot.docs.first;
        
        return {
          'hospitalId': doc.id,
          'hospitalData': doc.data() as Map<String, dynamic>
        };
      } else {
        return null; // No hospital found with the given name
      }
    } catch (e) {
      print('Error fetching hospital: $e');
      return null;
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
  
}
