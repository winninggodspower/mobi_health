import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobi_health/pages/authentication_pages/auth_success_page.dart';
import 'package:mobi_health/pages/dashboard_pages/components/dashboard_profile_notification.dart';
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
    return SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 39, 18, 34),
        child: ListView(
          children: [
            const DahsboardProfileNotificationWidget(),
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
            Column(
              children: [
                HealthCard(
                  leadingIcon: svg_assets.sleepCircleIcon,
                  title: 'Sleep',
                  subtitle: 'Total hours of sleep',
                  mainValue: '7.5 hours',
                  statusWidget: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary_200Color,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    child: Text(
                      '12:40 AM - \n 6:50 AM',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 14,
                        color: AppColors.primary_800Color,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  child: Column(
                    children: [
                      HealthCard(
                        leadingIcon: svg_assets.heartCircleIcon,
                        title: 'Heart Rate',
                        subtitle: 'current Heart rate',
                        mainValue: '75 bpm',
                        statusWidget: Row(
                          children: [
                            Text(
                              'Normal',
                              style: GoogleFonts.alegreya(
                                fontSize: 13.4,
                                fontWeight: FontWeight.w700
                              ),
                            ),
                            const SizedBox(width: 15,),
                            SvgPicture.asset(svg_assets.heartIcon)
                          ],
                        ),
                      ),
                      const SizedBox(height: 5,),
                      HealthCard(
                        leadingIcon: svg_assets.temperatureCircleIcon,
                        title: 'Body Temperature',
                        subtitle: 'current Temperature',
                        mainValue: '36.5°C',
                        statusWidget: Row(
                          children: [
                            Text(
                              'Low',
                              style: GoogleFonts.alegreya(
                                fontSize: 13.4,
                                fontWeight: FontWeight.w700
                              ),
                            ),
                            const SizedBox(width: 15,),
                            SvgPicture.asset(svg_assets.temperatureIcon)
                          ],
                        ),
                      ),
                      const SizedBox(height: 5,),
                      HealthCard(
                        leadingIcon: svg_assets.weightCircleIcon,
                        title: 'Weight',
                        subtitle: 'Recent measurement',
                        mainValue: '70Kg',
                        statusWidget: Row(
                          children: [
                            Text(
                              'Low',
                              style: GoogleFonts.alegreya(
                                fontSize: 13.4,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                            const SizedBox(width: 3,),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.secondary_500Color,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              child: Text(
                                '-10.5 kg',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 14,
                                  color: AppColors.gray,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5,),
                      HealthCard(
                        leadingIcon: svg_assets.stepsCircleIcon,
                        title: 'Steps/Activity',
                        subtitle: 'steps taken today',
                        mainValue: '135 steps',
                        statusWidget: Text(
                          'Low',
                          style: GoogleFonts.alegreya(
                            fontSize: 13.4,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
