
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:mobi_health/pages/dashboard_pages/components/hospital_dashboard_profile_notification.dart';
import 'package:mobi_health/services/hospital_page_service.dart';
import 'package:provider/provider.dart';
import 'package:mobi_health/providers/authentication_provider.dart';


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
  List<Map<String, dynamic>> users = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    final authProvider = context.read<AuthenticationProvider>();
    final user = authProvider.user;
    // fetchData(user!.uid);
  }

  Future<void> fetchData(hospitalId) async {
    try {
      List<Map<String, dynamic>> fetchedUsers =
          await fetchUsersWhoMessagedSpecificHospital(hospitalId);
      setState(() {
        users = fetchedUsers;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 39, 18, 34),
          child: Column(children: [
            HospitalDashboardProfileNotificationWidget(),
            const SizedBox(
              height: 10,
            ),
             
          ])),
    );
  }
}
