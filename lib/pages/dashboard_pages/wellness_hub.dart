import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobi_health/pages/dashboard_pages/components/article_card.dart';
import 'package:mobi_health/pages/dashboard_pages/components/dashboard_profile_notification.dart';
import 'package:mobi_health/theme.dart';

class WellnessHub extends StatefulWidget {
  const WellnessHub({super.key});

  @override
  State<WellnessHub> createState() => _WellnessHubState();
}

class _WellnessHubState extends State<WellnessHub> {
  late List<String> categories;
  late List<Map<String, String>> articles;
  late String selectedCategory;

  @override
  void initState() {
    articles = [
      {
        'title': 'Stages of pregnancy',
        'bodyText': 'Let’s open up to the things that matter among the people',
        'imagePath': 'assets/blog-preview-image.png',
        'tag': 'New',
        'category': 'For me',
      },
      {
        'title': 'Healthy Eating Habits',
        'bodyText': 'Discover the best practices for maintaining a healthy diet.',
        'imagePath': 'assets/blog-preview-image.png',
        'tag': 'Trending',
        'category': 'Self Care',
      },
      {
        'title': 'Exercise Tips for Beginners',
        'bodyText': 'Simple and effective exercise tips for those just starting out.',
        'imagePath': 'assets/blog-preview-image.png',
        'tag': 'Popular',
        'category': 'Pregnancy',
      },
      {
        'title': 'Mental Health Awareness',
        'bodyText': 'Understanding the importance of mental health in our daily lives.',
        'imagePath': 'assets/blog-preview-image.png',
        'tag': 'Important',
        'category': 'Mental Health',
      },
      {
        'title': 'Work-Life Balance',
        'bodyText': 'How to achieve a healthy work-life balance.',
        'imagePath': 'assets/blog-preview-image.png',
        'tag': 'Featured',
        'category': 'Self Care',
      },
    ];
    categories  = articles.map((article) => article['category']! ).toSet().toList();
    selectedCategory = categories.first;
    super.initState();
  }

  List<Map<String, String>> getFilteredArticles() {
    return articles.where((article) => article['category'] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 39, 18, 34),
        child: ListView(
          children: [
            DashboardProfileNotificationWidget(imageColor: AppColors.orangeLight, notificationColor: AppColors.orange ,),
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
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9.5),
                        decoration: BoxDecoration(
                          color: categories[index] == selectedCategory ? AppColors.primary_600Color : AppColors.gray3,
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Text(
                          categories[index],
                          style: GoogleFonts.epilogue(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: categories[index] == selectedCategory ? AppColors.customWhite : const Color(0xff8A8A8A),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 21,),
            ...getFilteredArticles().map((article) => Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: ArticleCard(
                title: article['title']!,
                bodyText: article['bodyText']!,
                imagePath: article['imagePath']!,
                tag: article['tag']!,
              ),
            )).toList(),
          ]
        ),
      ),
    );
  }
}