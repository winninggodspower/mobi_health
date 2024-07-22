
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/dashboard_pages/connect_device.dart';
import 'package:mobi_health/pages/onboarding.dart';
import 'package:mobi_health/pages/dashboard_pages/dashboard.dart';
import 'package:mobi_health/providers/authentication_provider.dart';
import 'package:mobi_health/providers/device_permission_provider.dart';


class GlobalVariable {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

@pragma('vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
  void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) {
      developer.log('the task got executed');
      switch (task) {
        case 'fetchHealthData':
          BuildContext? context = GlobalVariable.navigatorKey.currentContext;
           if (context != null) {
            HealthDataService(context: context).fetchHealthData();
          } else {
            // Handle the case where context is null, maybe log or retry
            print("Context is null, cannot fetch health data.");
          }
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
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
aster
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (context) => DevicePermissionProvider()),
        ChangeNotifierProvider(create: (context) => DashboardAction())
      ],
      child: MaterialApp(
        theme: appTheme,
er
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
