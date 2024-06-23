import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobi_health/theme.dart';

// class OnBoarding extends StatelessWidget

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(18, 75, 18, 60),
        child: Column(
          children: [
            Text(
              'OTP Verification',
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
