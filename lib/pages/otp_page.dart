import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobi_health/pages/dashboard/home_page.dart';
import 'package:mobi_health/theme.dart';
import 'package:mobi_health/util.dart';
import 'package:pinput/pinput.dart';

// class OnBoarding extends StatelessWidget

class OtpPage extends StatefulWidget {
  final String verificationId;

  const OtpPage({super.key, required this.verificationId});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
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
              onSubmitted: (value) {
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomePage()));
                } else {
                  ShowSnackBar(context, "Enter 6-digit code");
                }
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomePage()));
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> verifyOtpCode(BuildContext context, String optCode) async {
    print('verification running');
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: widget.verificationId, smsCode: optCode);

      UserCredential userCred =await FirebaseAuth.instance.signInWithCredential(creds);

      if (userCred.user != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomePage()));
      }
    } on FirebaseAuthException catch (e) {
      ShowSnackBar(context, e.message.toString());
    }
  }
}
