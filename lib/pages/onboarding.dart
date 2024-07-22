import 'package:flutter/material.dart';
import 'package:mobi_health/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SizedBox(
        width: double.infinity,
        height:  double.infinity,
        child: Stack(
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
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.15,
                          vertical: 20,
                        ),
                      ),
                      child: Text(
                        'Let Us Help You',
                        style: GoogleFonts.alegreyaSans(
                          fontSize: screenWidth * 0.055,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}
