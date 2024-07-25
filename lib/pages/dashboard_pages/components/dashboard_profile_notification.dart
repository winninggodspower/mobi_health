import 'package:flutter_svg/svg.dart';
import 'package:mobi_health/pages/dashboard_pages/action_dropDown/help/help_screen.dart';
import 'package:mobi_health/pages/dashboard_pages/emergency_contact.dart';
import '../action_dropDown/export_action_drop_down.dart';
import 'package:mobi_health/svg_assets.dart' as svg_assets;
import 'package:mobi_health/providers/authentication_provider.dart';
import 'package:mobi_health/pages/authentication/patient_pages/onBoardingSignup.dart';
import 'package:mobi_health/pages/dashboard_pages/action_dropDown/actionView/update_password.dart';
import 'package:mobi_health/pages/dashboard_pages/action_dropDown/personal_details/personal_details.dart';


class DashboardProfileNotificationWidget extends StatelessWidget {
  final Color imageColor;
  final Color notificationColor;
  final GlobalKey _key = GlobalKey();

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
        GestureDetector(
          key: _key,
          onTap: () {
            showPopupMenu(context);
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

  showPopupMenu(BuildContext context) {
    RenderBox renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    double left = offset.dx;
    double top = offset.dy + renderBox.size.height;

    return showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
          left, top, left + 1, top + 1), // Position of the menu
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(29),
      ),
      items: [
        PopupMenuItem<int>(
          value: 0,
          child: optionItem(
            text: 'Emergency contact',
            icon: iconContainer(
              Icons.phone_callback_outlined,
            ),
          ),
        ),
        PopupMenuItem<int>(
          value: 1,
          child: optionItem(
            text: 'Personal Details',
            icon: iconContainer(
              Icons.person_3_outlined,
            ),
          ),
        ),
        PopupMenuItem<int>(
          value: 2,
          child: optionItem(
            text: 'Update Password',
            icon: iconContainer(
              Icons.settings,
            ),
          ),
        ),
        PopupMenuItem<int>(
          value: 3,
          child: optionItem(
            text: 'Help',
            icon: iconContainer(Icons.question_mark_outlined),
          ),
        ),
        PopupMenuItem<int>(
          value: 4,
          child: optionItem(
            text: 'Logout',
            icon: SvgPicture.asset(
              svg_assets.logoutIcon,
            ),
            // iconPath: svg_assets.logoutIcon,
          ),
        ),
      ],
    ).then((value) {
      // Handle your logic based on the selected value
      if (value != null) {
        print('Selected value: $value');
        if (value == 4) {
          context.read<AuthenticationProvider>().signOut();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const OnBoardingSignup()));
        } else if (value == 0) {
          navigateTo(const EmergencyContact());
        } else if (value == 1) {
          navigateTo(DetailsView());
        } else if (value == 2) {
          navigateTo(const UpdatePasswordScreen());
        } else if (value == 3) {
          navigateTo(const HelpView());
        }
      }
    });
  }

  Widget optionItem({
    required String text,
    required Widget icon,
    // required String iconPath,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: icon,
        title:  Text(
          text,
        ), 
     
        trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 16),
      ),
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
