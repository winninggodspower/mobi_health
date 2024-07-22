import 'theme.dart';
import 'firebase_options.dart';
import 'widgets/navigations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/dashboard_pages/connect_device.dart';
import 'package:mobi_health/pages/onboarding.dart';
import 'package:mobi_health/pages/dashboard_pages/dashboard.dart';
import 'package:mobi_health/providers/authentication_provider.dart';
import 'package:mobi_health/providers/device_permission_provider.dart';
import 'pages/dashboard_pages/components/expert_chat_dashboard_page.dart';
import 'pages/dashboard_pages/wellness_hub/actionView/update_password.dart';
import 'package:mobi_health/pages/authentication/patient_pages/register.dart';
import 'package:mobi_health/pages/authentication/patient_pages/login_page.dart';
import 'package:mobi_health/pages/dashboard_pages/wellness_hub/wellness_hub.dart';
import 'package:mobi_health/pages/authentication/patient_pages/onBoardingSignup.dart';

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
        ChangeNotifierProvider(create: (context) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (context) => DevicePermissionProvider()),
        ChangeNotifierProvider(create: (context) => DashboardAction())
      ],
      child: MaterialApp(
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        navigatorKey: navigateKey,
        home: Consumer<AuthenticationProvider>(
          builder: (context, authProvider, child) {
            return
                // ExpertChatDashboardPage ();
                //  const WellnessHub();
                // const ConnectDevicePage();
                // authProvider.isLoggedIn
                //     ?
                const DashboardIndex();
            //     : const OnBoardingPage();
          },
        ),
        routes: {
          '/home': (context) => const SafeArea(child: OnBoardingPage()),
          '/register': (context) => const SafeArea(child: RegisterPage()),
          '/login': (context) => const SafeArea(child: LoginPage()),
          '/onboarding': (context) => const SafeArea(child: OnBoardingSignup()),
          '/dashboard': (context) => const SafeArea(child: DashboardIndex()),
          '/updateScreen': (context) => const SafeArea(child: UpdatePasswordScreen()),
        },
      ),
    );
  }
}
