import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobi_health/pages/dashboard_pages/components/dashboard_profile_notification.dart';
import 'package:mobi_health/theme.dart';

class ExpertChatDashboardPage extends StatefulWidget {
  const ExpertChatDashboardPage({super.key});

  @override
  State<ExpertChatDashboardPage> createState() => _ExpertChatDashboardPageState();
}

class _ExpertChatDashboardPageState extends State<ExpertChatDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 39, 0, 34),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DashboardProfileNotificationWidget(imageColor: AppColors.orangeLight, notificationColor: AppColors.orange,),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Chat',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                        color: AppColors.gray),
                  ),
                  const SizedBox(height: 3,),
                  Text(
                    'Reach out to a professional and table your worries, they are here to listen and help you. ',
                    style: GoogleFonts.alegreyaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        ),
                  ),
                  const SizedBox(height: 35,),
                  Text(
                    'Your Hospital',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  Text(
                    'Your hospital has a team on Mubi to help you. Message them or hit the emergency botten to get them attend to your ',
                    style: GoogleFonts.alegreyaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        ),
                  ),
                  const SizedBox(height: 27,),
                ],
              ),
            ),
            const ExpertChatNotification(bgColor: AppColors.primary100Color,),
            const SizedBox(height: 39.47,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mubi Chat',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  const SizedBox(height: 3,),
                  Text(
                    'We also have a team of professional mental health experts on  Mubi to help you. Message them or hit the emergency botten to get them attend to your',
                    style: GoogleFonts.alegreyaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        ),
                  ),
                  const SizedBox(height: 5,),
                ],
              ),
            ),
            const ExpertChatNotification(bgColor: AppColors.primary50Color,),
          ],
        )
      )
    );
  }
}

class ExpertChatNotification extends StatelessWidget {
  final Color bgColor;

  const ExpertChatNotification({
    super.key,
    required this.bgColor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Badge(
                  backgroundColor: Color(0xff23BD33),
                  child: Image.asset('assets/mobi-health-logo.png'),
              ),
              const SizedBox(width: 14.13,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MUBI HEALTH DIGITAL',
                    style: GoogleFonts.openSans(
                      fontSize: 12.37,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  const SizedBox(height: 3.5,),
                  Text(
                    'Yeah sure, tell me zafor',
                    style: GoogleFonts.inter(
                      fontSize: 12.37,
                      color: AppColors.gray2
                    ),
                  )
                ],
              )
          ],),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'just now',
                style: GoogleFonts.inter(
                  fontSize: 12.37,
                  color: AppColors.gray2
                ),
              ),
              const SizedBox(height: 10,),
              Container(height: 7, width: 7, decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(0xff3A6AB3),
              ),)
            ]
          ),
        ],
      ),
    );
  }
}