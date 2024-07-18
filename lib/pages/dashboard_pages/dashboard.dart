import 'package:flutter/material.dart';
import 'package:mobi_health/pages/dashboard_pages/components/bottom_navigation.dart';
import 'package:mobi_health/pages/dashboard_pages/components/expert_chat_dashboard_page.dart';
import 'package:mobi_health/pages/dashboard_pages/connect_device.dart';
import 'package:mobi_health/pages/dashboard_pages/home_page.dart';
import 'package:mobi_health/pages/dashboard_pages/wellness_hub/wellness_hub.dart';
import 'package:permission_handler/permission_handler.dart';

class DashboardIndex extends StatefulWidget {
  const DashboardIndex({super.key});

  @override
  State<DashboardIndex> createState() => _DashboardIndexState();
}

class _DashboardIndexState extends State<DashboardIndex> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;
  bool _permissionsGranted = false;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _checkPermissions() async {
    PermissionStatus activityRecognitionStatus = await Permission.activityRecognition.status;
    PermissionStatus locationStatus = await Permission.location.status;

    if (activityRecognitionStatus.isGranted && locationStatus.isGranted) {
      setState(() {
        _permissionsGranted = true;
      });
    } else {
      _askPermission();
    }
  }

  void _askPermission() async {
    PermissionStatus activityRecognitionStatus = await Permission.activityRecognition.request();
    PermissionStatus locationStatus = await Permission.location.request();

    if (activityRecognitionStatus.isGranted && locationStatus.isGranted) {
      setState(() {
        _permissionsGranted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _permissionsGranted
          ? AppButtomNavigation(
              pageController: _pageController,
              selectedIndex: _selectedIndex,
            )
          : null,
      body: _permissionsGranted
          ? PageView(
              controller: _pageController,
              children: const [
                HomePage(),
                ExpertChatDashboardPage(),
                WellnessHub(),
                ConnectDevicePage(),
              ],
              onPageChanged: (value) {
                setState(() {
                  _selectedIndex = value;
                });
              },
            )
          : _PermissionsRequiredPage(onRetry: _checkPermissions),
    );
  }
}

class _PermissionsRequiredPage extends StatelessWidget {
  final VoidCallback onRetry;

  const _PermissionsRequiredPage({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'You need to accept these permissions to access this page.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
