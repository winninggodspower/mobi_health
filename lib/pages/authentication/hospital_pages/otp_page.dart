import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobi_health/pages/authentication/patient_pages/auth_success_page.dart';

import 'package:mobi_health/theme.dart';
import 'package:mobi_health/util.dart';
import 'package:pinput/pinput.dart';

class HospitalOtpVerificationPage extends StatefulWidget {
  final String verificationId;
  final String hospitalName;
  final String phoneNumber;
  final String region;
  final String city;

  HospitalOtpVerificationPage({
    required this.verificationId,
    required this.hospitalName,
    required this.phoneNumber,
    required this.region,
    required this.city,
  });

  @override
  State<HospitalOtpVerificationPage> createState() => _HospitalOtpVerificationPageState();
}

class _HospitalOtpVerificationPageState extends State<HospitalOtpVerificationPage> {
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
        backgroundColor: AppColors.primary_500Color,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(18, 75, 18, 34),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back, color: Colors.white, size: 24,)
                        ),
                        const SizedBox(width: 8,),
                        Text(
                          'Phone Number Verifcation',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: AppColors.customWhite,
                              fontSize: 24,
                            ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 9,),
                    Text(
                      'We will use the number to verify you every time you login for security reasons.',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.white,),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(23, 64, 23, 23),
                  decoration: const BoxDecoration(
                    color: AppColors.customWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(31.0),
                      topRight: Radius.circular(31.0),
                    ),
                  ),
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
                        color: Color(0xFF858585),
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
                      // verifyOtpCode(context, otpCode!);
                    } else {
                      ShowSnackBar(context, "Enter 6-digit code");
                    }
                  },
                  child: const Text('Next'),
                ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ));
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

      // add display name
      await userCredential.user?.updateDisplayName(widget.hospitalName.trim());

      // Create user in your Firestore database
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'phoneNumber': widget.phoneNumber,
        'email': email,
        'userType': 'hospital',
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Create hospital liked to user in firestore database
      await _firestore.collection('hospital').doc(userCredential.user?.uid).set({
        'name': widget.hospitalName,
        'region': widget.region,
        'city': widget.city,
      });

      if (userCredential.user != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const OtpSuccessPage()));
      }

    } on FirebaseAuthException catch (e) {
      ShowSnackBar(context, e.message.toString());
    }
  }
}