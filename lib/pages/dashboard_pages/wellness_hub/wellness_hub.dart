import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:mobi_health/theme.dart';
import 'package:provider/provider.dart';
import 'actionView/update_password.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobi_health/widgets/navigations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../providers/device_permission_provider.dart';
import 'package:mobi_health/pages/dashboard_pages/wellness_hub/article_card.dart';
import 'package:mobi_health/pages/dashboard_pages/components/dashboard_profile_notification.dart';

class WellnessHub extends StatefulWidget {
  const WellnessHub({super.key});

  @override
  State<WellnessHub> createState() => _WellnessHubState();
}

class _WellnessHubState extends State<WellnessHub> {
  List<dynamic> categories = [];
  List<Map<String, dynamic>> articles = [];
  String selectedCategory = '';
  int userPregnancyDuration = 0;

  @override
  void initState() {
    super.initState();
    fetchArticles();
  }

  Future<void> fetchArticles() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('articles').get();

    final fetchedArticles =
        querySnapshot.docs.map((doc) => doc.data()).toList();

    setState(() {
      articles = fetchedArticles;
      categories = articles
          .map((article) => article['category'] as String)
          .toSet()
          .toList();
      categories.insert(0, 'For Me');
      selectedCategory = categories.first;
    });
  }

  List<Map<String, dynamic>> getFilteredArticles() {
    if (selectedCategory == 'For Me') {
      return articles.where((article) {
        int? targetDuration = article['targetPregnancyDuration'] as int?;
        bool upward = article['upwards'] as bool;

        // If targetDuration is null, you can choose how to handle it:
        // Option 1: Skip articles with null target duration
        if (targetDuration == null) return false;

        if (upward) {
          return userPregnancyDuration >= targetDuration;
        } else {
          return userPregnancyDuration <= targetDuration;
        }
      }).toList();
    } else {
      return articles
          .where((article) => article['category'] == selectedCategory)
          .toList();
    }
  }

  String formatDate(Timestamp timestamp) {
    var date = timestamp.toDate();
    return DateFormat('d MMMM y').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 39, 18, 34),
          child: Stack(
            children: [
              ListView(children: [
                DashboardProfileNotificationWidget(
                  imageColor: AppColors.orangeLight,
                  notificationColor: AppColors.orange,
                ),
                const SizedBox(
                  height: 48,
                ),
                Text(
                  'Wellness Hub',
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff371B34)),
                ),
                const SizedBox(
                  height: 14,
                ),
                SizedBox(
                  height: 38,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = categories[index];
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 9.5),
                            decoration: BoxDecoration(
                              color: categories[index] == selectedCategory
                                  ? AppColors.primary_600Color
                                  : AppColors.gray3,
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Text(
                              categories[index],
                              style: GoogleFonts.epilogue(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: categories[index] == selectedCategory
                                    ? AppColors.customWhite
                                    : const Color(0xff8A8A8A),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 21,
                ),
                ...getFilteredArticles()
                    .map((article) => Padding(
                          padding: const EdgeInsets.only(bottom: 7),
                          child: ArticleCard(
                            title: article['title']!,
                            subTitle: article['subTitle']!,
                            bodyText: article['bodyText']!,
                            imagePath: "assets/blog-preview-image.png",
                            tag: article['tag']!,
                            date: formatDate(article['createdAt'] as Timestamp),
                          ),
                        ))
                    .toList(),
              ]),
              const DisplayActionList()
            ],
          )),
    );
  }
}

class DisplayActionList extends StatefulWidget {
  const DisplayActionList({super.key});

  @override
  State<DisplayActionList> createState() => _DisplayActionListState();
}

class _DisplayActionListState extends State<DisplayActionList> {
  Timer? _timer;
  bool initValue = false;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final value = Provider.of<DashboardAction>(context, listen: false).value;
      setState(() {
        initValue = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      left: 5,
      right: 5,
      bottom: 80,
      child: initValue
          ? Container(
              width: 90,
              margin: const EdgeInsets.only(bottom: 120),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(17),
                  border: Border.all(color: Colors.blue, width: 2)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      listOfAction(() {}, Icons.phone_callback_outlined,
                          'Emergency contact'),
                      listOfAction(
                          () {}, Icons.person_3_outlined, 'Personal Details'),
                      listOfAction(() {
                        navigateTo(const UpdatePasswordScreen());
                      }, Icons.settings, 'Update Password'),
                      listOfAction(() {}, Icons.question_mark_outlined, 'Help'),
                      listOfAction(() {}, Icons.logout_rounded, 'Logout',
                          bkColor: AppColors.secondary_500Color,
                          iconColor: AppColors.secondaryColor),
                    ],
                  ),
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}

Widget listOfAction(VoidCallback onTap, IconData icon, String text,
    {Color bkColor = AppColors.primary_200Color,
    Color iconColor = AppColors.primary_800Color}) {
  return GestureDetector(
    onTap: onTap,
    child: ListTile(
      leading: Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bkColor,
        ),
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
      title: Text(
        text,
        style: GoogleFonts.openSans(fontSize: 13, color: Colors.black),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        color: AppColors.gray,
      ),
    ),
  );
}
