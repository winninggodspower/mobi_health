import 'package:flutter/material.dart';
import 'package:mobi_health/theme.dart';

class DahsboardProfileNotificationWidget extends StatelessWidget {
  const DahsboardProfileNotificationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(0xff3A6AB3),
              ),
          child: Image.asset('assets/avatar.png') //profile image of logged in image,
        ),
        const Badge(
          label: Text('2'),
          backgroundColor: AppColors.secondaryColor,
          child: Icon(
            Icons.notifications_outlined,
            size: 35,
          ),
        )
      ],
    );
  }
}