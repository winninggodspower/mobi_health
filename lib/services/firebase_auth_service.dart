import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signup({required String phoneNumber}) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
