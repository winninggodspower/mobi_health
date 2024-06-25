import 'package:flutter/material.dart';
import 'package:mobi_health/pages/onBoardingSignup.dart';
import 'package:mobi_health/pages/onboarding.dart';
import 'package:mobi_health/pages/otp_page.dart';
import 'package:mobi_health/pages/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobi_health/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> AuthProvider())
      ],
      child: MaterialApp(
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => const SafeArea(child: OnBoardingPage()),
          '/register': (context) => const SafeArea(child: RegisterPage()),
          '/onboarding': (context) => const SafeArea(child: OnBoardingSignup()),
          // '/otp': (context) => const SafeArea(child: OtpPage()),
        },
      ),
    );
  }
}
