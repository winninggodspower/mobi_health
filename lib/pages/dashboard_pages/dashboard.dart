import 'package:flutter/material.dart';
import 'package:mobi_health/pages/dashboard_pages/components/bottom_navigation.dart';
import 'package:mobi_health/pages/dashboard_pages/components/expert_chat_dashboard_page.dart';
import 'package:mobi_health/pages/dashboard_pages/connect_device.dart';
import 'package:mobi_health/pages/dashboard_pages/home_page.dart';
import 'dart:developer';

import 'package:mobi_health/pages/dashboard_pages/wellness_hub/wellness_hub.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppButtomNavigation(
        pageController: _pageController,
        selectedIndex: _selectedIndex,
      ),
      body: PageView(
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
      ),
    );
  }
}