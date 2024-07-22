import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobi_health/pages/authentication/patient_pages/login_page.dart';
import 'package:mobi_health/pages/authentication/patient_pages/onBoardingSignup.dart';
import 'package:mobi_health/pages/dashboard_pages/dashboard.dart';
import 'package:mobi_health/pages/onboarding.dart';
import 'package:mobi_health/pages/authentication/patient_pages/register.dart';

import 'package:mobi_health/providers/authentication_provider.dart';
import 'package:mobi_health/providers/device_permission_provider.dart';
import 'package:mobi_health/services/notification_service.dart';
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

    // initialize notification service
    NotificationService(context: context).init();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> AuthenticationProvider()),
        ChangeNotifierProvider(create: (context)=> DevicePermissionProvider())
      ],
      child: MaterialApp(
        theme: appTheme,
        home: Consumer<AuthenticationProvider>(
          builder: (context, authProvider, child) {
            return authProvider.isLoggedIn ? const DashboardIndex() : const OnBoardingPage();
          },
        ),
        routes: {
          '/home': (context) => const SafeArea(child: OnBoardingPage()),
          '/register': (context) => const SafeArea(child: RegisterPage()),
          '/login': (context) => const SafeArea(child: LoginPage()),
          '/onboarding': (context) => const SafeArea(child: OnBoardingSignup()),
          '/dashboard': (context) => const SafeArea(child: DashboardIndex()),
        },
      ),
    );
  }
}
