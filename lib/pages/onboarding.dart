import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobi_health/theme.dart';

// class OnBoarding extends StatelessWidget

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/onboarding-bg.png',
              fit: BoxFit.cover,
            )
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(45, 59, 45, 65),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "It’s Ok Not To Be OKAY !!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0,
                      color: Colors.white,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/onboarding');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryColor,
                      textStyle: GoogleFonts.alegreyaSans(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w500,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                    ),
                    child: const Text('Let Us Help You'),
                  )
                ],
              ),
            ),
          ),
        ]
      ),
    );
  }
}
