import 'package:flutter/material.dart';
import 'package:mobi_health/theme.dart';

class DashboardProfileNotificationWidget extends StatelessWidget {
  Color imageColor;
  Color notificationColor;


  DashboardProfileNotificationWidget({
    super.key,
    this.imageColor = const Color(0xff3A6AB3),
    this.notificationColor = AppColors.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: imageColor,
              ),
          child: Image.asset('assets/profile-pic.png', width: 35,) //profile image of logged in image,
        ),
        Badge(
          label: const Text('2'),
          backgroundColor: notificationColor,
          child: const Icon(
            Icons.notifications_outlined,
            size: 35,
          ),
        )
      ],
    );
  }
}