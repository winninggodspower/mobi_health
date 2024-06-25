import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobi_health/theme.dart';
import 'package:pinput/pinput.dart';

// class OnBoarding extends StatelessWidget

class OtpPage extends StatelessWidget {
  final String verificationId;

  const OtpPage({super.key, required this.verificationId});

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
            const SizedBox(height: 13,),
            Text(
              'We sent in an account verification code to your phone nuber. Type it in here ',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 18,
                  ),
            ),
            const SizedBox(height: 26,),
            const Pinput(
              length: 6,
              showCursor: true,
            ),
            const SizedBox(height: 24,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: GoogleFonts.alegreyaSans(
                  fontSize: 19,
                  fontWeight: FontWeight.w400,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 52, vertical: 21),
              ),
              onPressed: () {},
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
