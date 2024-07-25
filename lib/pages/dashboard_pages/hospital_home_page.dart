import 'dart:convert';
import 'package:health/health.dart';
import 'dart:developer' as developer;
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:mobi_health/theme.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobi_health/services/health_service.dart';
import 'package:mobi_health/svg_assets.dart' as svg_assets;
import 'package:mobi_health/providers/health_data_provider.dart';
import 'package:mobi_health/providers/authentication_provider.dart';
import 'package:mobi_health/pages/dashboard_pages/connect_device.dart';
import 'package:mobi_health/health_connect_settings.dart' as health_settings;
import 'package:mobi_health/pages/dashboard_pages/components/health_card.dart';
import 'package:mobi_health/pages/dashboard_pages/wellness_hub/wellness_hub.dart';
import 'package:mobi_health/pages/dashboard_pages/components/dashboard_profile_notification.dart';

class HospitalHomePage extends StatefulWidget {
  final PageController pageController;

  const HospitalHomePage({
    super.key,
    required this.pageController,
  });

  @override
  State<HospitalHomePage> createState() => _HospitalHomePageState();
}

class _HospitalHomePageState extends State<HospitalHomePage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthenticationProvider>();
    final user = authProvider.user;
    final userInfo = authProvider.userInfo;
    developer.log(userInfo.toString());

    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 39, 18, 34),
          child: ListView(children: [
            DashboardProfileNotificationWidget(),
            const SizedBox(
              height: 10,
            ),
          ])),
    );
  }
}
