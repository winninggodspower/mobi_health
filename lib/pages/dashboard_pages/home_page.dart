import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobi_health/pages/dashboard_pages/components/bottom_navigation.dart';
import 'package:mobi_health/pages/dashboard_pages/components/health_card.dart';
import 'package:mobi_health/svg_assets.dart' as svg_assets;
import 'package:mobi_health/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const AppButtomNavigation(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 75, 18, 34),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/avatar.png'),
                const Badge(
                  label: Text('2'),
                  backgroundColor: AppColors.secondaryColor,
                  child: Icon(
                    Icons.notifications_outlined,
                    size: 35,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Welcome back, Vong!',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  color: AppColors.gray),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Pregnancy week : 13',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors.gray),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              '3rd Trimester',
              style: GoogleFonts.alegreya(
                  fontSize: 11.11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.gray),
            ),
            const SizedBox(
              height: 22,
            ),
            Text(
              'Processed Information',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(
              height: 6,
            ),
            const   Column(
              children: [
                HealthCard(
                  leadingIcon: svg_assets.sleepCircleIcon,
                  title: 'Sleep',
                  subtitle: 'Total hours of sleep',
                  mainValue: '7.5 hours',
                  trailingIcon: svg_assets.lightBulbIcon,
                  additionalInfo: '12:40 AM - \n 6:50 AM',
                ),
                SizedBox(height: 5,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7),
                  child: Column(
                    children: [
                      HealthCard(
                        leadingIcon: svg_assets.heartCircleIcon,
                        title: 'Heart Rate',
                        subtitle: 'current Heart rate',
                        mainValue: '75 bpm',
                        trailingIcon: svg_assets.lightBulbIcon,
                        additionalInfo: '12:40 AM - \n 6:50 AM',
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
