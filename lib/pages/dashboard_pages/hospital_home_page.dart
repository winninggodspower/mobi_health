import 'package:mobi_health/pages/dashboard_pages/action_dropDown/export_action_drop_down.dart';
import 'package:mobi_health/pages/dashboard_pages/chat/chat_page.dart';
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
    if(user?.uid != null ){
      fetchData(user!.uid);
    }
  }

  Future<void> fetchData(hospitalId) async {
    try {
      List<Map<String, dynamic>> fetchedUsers =
          await fetchUsersWhoMessagedSpecificHospital(hospitalId);
      setState(() {
        users = fetchedUsers;
        print(users);
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
              height: 40,
            ),
            isLoading
            ? const Center(child: CircularProgressIndicator())
            : hasError
                ? const Center(child: Text('Error loading users'))
                : users.isEmpty
                    ? Center(child: Text('No users found'))
                    : Expanded(
                        child: ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          var user = users[index];
                          return InkWell(
                            onTap: (){
                              navigateTo(ChatPage(receiverId: user['userId'], receiverType: 'patient', receiverName:user['name'],));
                            },
                            child: Container(
                              padding:  EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.primary_600Color),
                                borderRadius: BorderRadius.circular(6.0),
                                color: Colors.white,
                              ),
                              child: ListTile(
                                leading: Image.network('https://avatar.iran.liara.run/public/', width: 35),
                                title: Text(user['name']),
                                subtitle: Text('view chat', style: Theme.of(context).textTheme.bodySmall),
                              )
                            )
                          );
                        },
                      ),
                      )
          ])),
    );
  }
}
