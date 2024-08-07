import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobi_health/pages/authentication/patient_pages/auth_success_page.dart';
import 'package:mobi_health/pages/dashboard_pages/dashboard.dart';
import 'package:mobi_health/pages/dashboard_pages/home_page.dart';
import 'package:mobi_health/theme.dart';
import 'package:mobi_health/util.dart';
import 'package:pinput/pinput.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// class OnBoarding extends StatelessWidget

class OtpVerificatonPage extends StatefulWidget {
  final String verificationId;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final int durationOfPregnancy;
  final String hospital;
  final String phoneNumber;
  final String password;

  OtpVerificatonPage({
    required this.verificationId,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.durationOfPregnancy,
    required this.hospital,
    required this.phoneNumber,
    required this.password,
  });

  @override
  State<OtpVerificatonPage> createState() => _OtpVerificatonPageState();
}

class _OtpVerificatonPageState extends State<OtpVerificatonPage> {
  late final TextEditingController pinController;

  String? otpCode;

  @override
  void initState() {
    super.initState();
    pinController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.customWhite,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(18, 75, 18, 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'OTP Verification',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 19.22,
                  ),
            ),
            const SizedBox(
              height: 13,
            ),
            Text(
              'We sent in an account verification code to your phone nuber. Type it in here ',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 18,
                  ),
            ),
            const SizedBox(
              height: 26,
            ),
            Pinput(
              length: 6,
              showCursor: true,
              controller: pinController,
              defaultPinTheme: PinTheme(
                width: 49,
                height: 64,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black)),
              ),
              onCompleted: (pin){
                print('on complete was called');
                setState(() {
                  otpCode = pin;
                });
              },
              onChanged: (value) {
                setState(() {
                  otpCode = value;
                });
              },
            ),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: GoogleFonts.alegreyaSans(
                  fontSize: 19,
                  fontWeight: FontWeight.w400,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 52, vertical: 21),
              ),
              onPressed: () {
                if (otpCode != null) {
                  verifyOtpCode(context, otpCode!);
                } else {
                  ShowSnackBar(context, "Enter 6-digit code");
                }
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> verifyOtpCode(BuildContext context, String optCode) async {
    final _auth = FirebaseAuth.instance; 
    final _firestore = FirebaseFirestore.instance;

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: optCode
    );

    try {
      UserCredential userCredential =await _auth.signInWithCredential(credential);

      // Construct email using phone number (for linking accounts)
      String email = '${widget.phoneNumber.trim()}@example.com'.toLowerCase();
      print('email: ' + email);

      // Link with email/password credential
      await userCredential.user?.linkWithCredential(EmailAuthProvider.credential(email: email, password: widget.password));
      await userCredential.user?.updateDisplayName(widget.firstName.trim());

       // Create user in your Firestore database
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'phoneNumber': widget.phoneNumber,
        'email': email,
        'userType': 'patient',
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Create hospital liked to user in firestore database
      await _firestore.collection('patient').doc(userCredential.user?.uid).set({
        'firstName': widget.firstName.trim(),
        'lastName': widget.lastName.trim(),
        'dateOfBirth': widget.dateOfBirth,
        'durationOfPregnancy': widget.durationOfPregnancy,
        'hospital': widget.hospital,
      });

      if (userCredential.user != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const OtpSuccessPage()));
      }
    } on FirebaseAuthException catch (e) {
      ShowSnackBar(context, e.message.toString());
    }
  }
}
