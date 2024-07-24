import '../export_action_drop_down.dart';
import 'package:mobi_health/svg_assets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HelpView extends StatelessWidget {
  const HelpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: appAppBar('Help'),
        body: SafeArea(
          child: SizedBox(
            width: 100.w,
            height: 100.h,
            child: Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
              child: Column(
                children: [
                  Flexible(
                      flex: 9,
                      child: Column(
                        children: [
                          listOfOptions(fqaIconSvgIcon, 'FQA'),
                          listOfOptions(aboutIconSvgIcon, 'About Us'),
                          listOfOptions(privacyPolicySvgIcon, 'Privacy policy'),
                        ],
                      )),
                  Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 18.w,
                            height: 10.h,
                            decoration: BoxDecoration(
                              color: AppColors.primary_200Color,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(9),
                              child: SvgPicture.asset(
                                chatUsIcon,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 7, bottom: 7),
                            child: Container(
                              width: 40.w,
                              height: 10.h,
                              decoration: const BoxDecoration(
                                color: AppColors.primary_200Color,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                              ),
                              child: Center(
                                child: Text(
                                  'Chat with us',
                                  style: GoogleFonts.openSans(
                                    fontSize: 20,
                                    color: AppColors.primary_800Color,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          
                        ],
                      )),
                      SizedBox(height: 3.h,)
                ],
              ),
            ),
          ),
        ));
  }

  listOfOptions(String iconName, String text) => ListTile(
        leading: Container(
          width: 33,
          height: 33,
          decoration: const BoxDecoration(
            color: AppColors.primary_200Color,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SvgPicture.asset(
              iconName,
            ),
          ),
        ),
        title: Text(
          text,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: AppColors.gray2,
        ),
      );
}
