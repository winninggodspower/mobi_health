import 'theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/notification_service.dart';
import 'providers/health_data_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobi_health/firebase_options.dart';
import 'pages/dashboard_pages/connect_device.dart';
import 'package:mobi_health/pages/onboarding.dart';
import 'pages/authentication/patient_pages/register.dart';
import 'pages/authentication/patient_pages/login_page.dart';
import 'pages/authentication/patient_pages/onBoardingSignup.dart';
import 'package:mobi_health/pages/dashboard_pages/dashboard.dart';
import 'package:mobi_health/providers/authentication_provider.dart';
import 'package:mobi_health/providers/device_permission_provider.dart';







class GlobalVariable {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

@pragma('vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
  void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) {
      developer.log('the task got executed $task with data $inputData');
      switch (task) {
        case 'fetchHealthData':
          final provider = HealthDataProvider();
          provider.fetchHealthData();
          break;
      }
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // initalize background workmanager
  await Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true
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
        ChangeNotifierProvider(create: (context)=> DevicePermissionProvider()),
        ChangeNotifierProvider(create: (context)=> HealthDataProvider()),
        ChangeNotifierProvider(create: (context) => DashboardAction())
      ],
      child: MaterialApp(
        theme: appTheme,
        home: Consumer<AuthenticationProvider>(
          builder: (context, authProvider, child) {
            return
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
        },
      ),
    );
  }
}
