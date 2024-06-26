import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobi_health/theme.dart';

// class OnBoarding extends StatelessWidget

class OnBoardingSignup extends StatelessWidget {
  const OnBoardingSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(18, 75, 18, 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  "Let’s go through this journey to bringing a new being to life together",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 26.0,
                        height: 1.2,
                        color: Colors.white,
                      ),
                ),
                const SizedBox(
                  height: 36,
                ),
                Center(
                  child: Image.asset('assets/logo.png'),
                ),
                const SizedBox(height: 25),
                Text(
                  "Check your vitals all in one place and be up to date with your mental health status",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1,
                      color: Color(0xFFFBFCFE),
                    ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  width: 271,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary_800Color,
                      textStyle: GoogleFonts.alegreyaSans(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w500,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70, vertical: 15),
                    ),
                    child: const Text('Sign Up'),
                  ),
                ),
                const SizedBox(
                  height: 13,
                ),
                Text(
                  'Already have an account ? sign in',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: 22,
                ),
                SizedBox(
                  width: 271,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryColor,
                      textStyle: GoogleFonts.alegreyaSans(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w500,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70, vertical: 15),
                    ),
                    child: const Text('visit as guest'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
