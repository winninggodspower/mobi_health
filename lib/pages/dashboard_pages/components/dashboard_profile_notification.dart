import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobi_health/pages/authentication/patient_pages/onBoardingSignup.dart';
import 'package:mobi_health/providers/authentication_provider.dart';
import 'package:mobi_health/theme.dart';
import 'package:mobi_health/svg_assets.dart' as svg_assets;
import 'package:provider/provider.dart';

class DashboardProfileNotificationWidget extends StatelessWidget {
  Color imageColor;
  Color notificationColor;
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
          child: Text('First Option'),
        ),
        PopupMenuItem<int>(
          value: 1,
          child: Text('Second Option'),
        ),
        PopupMenuItem<int>(
          value: 2,
          child: OptionItem(
            text: 'Logout',
            iconPath: svg_assets.logoutIcon,
          ),
        ),
      ],
    ).then((value) {
      // Handle your logic based on the selected value
      if (value != null) {
        print('Selected value: $value');
        if (value == 2) {
          context.read<AuthenticationProvider>().signOut();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const OnBoardingSignup()));
        }
      }
    });
  }

  Widget OptionItem({
    required String text,
    required String iconPath,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: SvgPicture.asset(
          iconPath,
        ),
        title: Text(text),
        trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 16),
      ),
    );
  }
}
