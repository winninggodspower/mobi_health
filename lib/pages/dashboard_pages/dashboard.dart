import 'package:flutter/material.dart';
import 'package:mobi_health/pages/dashboard_pages/components/hospital_bottom_navigation.dart';
import 'package:mobi_health/pages/dashboard_pages/hospital_home_page.dart';
import 'package:provider/provider.dart';
import 'package:mobi_health/pages/dashboard_pages/home_page.dart';
import 'package:mobi_health/providers/authentication_provider.dart';
import 'package:mobi_health/pages/dashboard_pages/connect_device.dart';
import 'package:mobi_health/pages/dashboard_pages/wellness_hub/wellness_hub.dart';
import 'package:mobi_health/pages/dashboard_pages/components/bottom_navigation.dart';
import 'package:mobi_health/pages/dashboard_pages/expert_chat_dashboard_page.dart';


class DashboardIndex extends StatefulWidget {
  const DashboardIndex({super.key});

  @override
  State<DashboardIndex> createState() => _DashboardIndexState();
}

class _DashboardIndexState extends State<DashboardIndex> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void askPermission() async {

  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthenticationProvider>();
    final user = authProvider.user;
    final userInfo = authProvider.userInfo;

    if (userInfo?['userType'] == 'hospital') {
      return hostpitalDashboard();
    }
    else{
      return patientDashboard();
    }

  }

  Widget patientDashboard(){
    return Scaffold(
      bottomNavigationBar: AppButtomNavigation(
        pageController: _pageController,
        selectedIndex: _selectedIndex,
      ),
      body: PageView(
        controller: _pageController,
        children: [
          HomePage(pageController: _pageController),
          const ExpertChatDashboardPage(),
          const WellnessHub(),
          const ConnectDevicePage(),
        ],
        onPageChanged: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
    );
  }

  Widget hostpitalDashboard(){
    return Scaffold(
      bottomNavigationBar: HospitalAppButtomNavigation(
        pageController: _pageController,
        selectedIndex: _selectedIndex,
      ),
      body: PageView(
        controller: _pageController,
        children: [
          HospitalHomePage(pageController: _pageController),
          const WellnessHub(),
          Consumer<AuthenticationProvider>(
            builder: (context, authProvider, _) {
              return ElevatedButton(onPressed: (authProvider.signOut), child: Text('logout'));
            }
          ),
        ],
        onPageChanged: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
    );
  }
  
}