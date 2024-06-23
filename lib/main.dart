import 'package:flutter/material.dart';
import 'package:mobi_health/pages/onBoardingSignup.dart';
import 'package:mobi_health/pages/onboarding.dart';
import 'package:mobi_health/pages/otp_page.dart';
import 'package:mobi_health/pages/register.dart';

import 'theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SafeArea(child: OnBoardingPage()),
        '/register': (context) => const SafeArea(child: RegisterPage()),
        '/onboarding': (context) => const SafeArea(child: OnBoardingSignup()),
        '/otp': (context) => const SafeArea(child: OtpPage()),
      },
    );
  }
}
