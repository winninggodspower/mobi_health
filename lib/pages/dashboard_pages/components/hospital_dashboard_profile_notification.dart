import 'package:flutter_svg/svg.dart';
import 'package:mobi_health/pages/dashboard_pages/action_dropDown/help/help_screen.dart';
import 'package:mobi_health/pages/dashboard_pages/emergency_contact.dart';
import '../action_dropDown/export_action_drop_down.dart';
import 'package:mobi_health/svg_assets.dart' as svg_assets;
import 'package:mobi_health/providers/authentication_provider.dart';
import 'package:mobi_health/pages/authentication/patient_pages/onBoardingSignup.dart';
import 'package:mobi_health/pages/dashboard_pages/action_dropDown/actionView/update_password.dart';
import 'package:mobi_health/pages/dashboard_pages/action_dropDown/personal_details/personal_details.dart';


class HospitalDashboardProfileNotificationWidget extends StatelessWidget {
  final Color imageColor;
  final Color notificationColor;
  final GlobalKey _key = GlobalKey();

  HospitalDashboardProfileNotificationWidget({
    super.key,
    this.imageColor = const Color(0xff3A6AB3),
    this.notificationColor = AppColors.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          key: _key,
          onTap: () {
          },
          child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: imageColor,
              ),
              child: Image.asset(
                'assets/profile-pic.png',
                width: 35,
              ) //profile image of logged in image,
              ),
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

  Widget iconContainer(
    IconData icon,
  ) {
    return Container(
      width: 33,
      height: 33,
      decoration: const BoxDecoration(
        color: AppColors.primary_200Color,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          icon,
          color: AppColors.primary_800Color,
          size: 20,
        ),
      ),
    );
  }
}
