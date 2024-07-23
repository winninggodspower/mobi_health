import 'export_action_drop_down.dart';


class DisplayActionList extends StatefulWidget {
  const DisplayActionList({super.key});

  @override
  State<DisplayActionList> createState() => _DisplayActionListState();
}

class _DisplayActionListState extends State<DisplayActionList> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      left: 5,
      right: 5,
      bottom: 80,
      child: context.watch<DashboardAction>().value
          ? Container(
              width: 90,
              margin: const EdgeInsets.only(bottom: 120),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(17),
                  border: Border.all(color: Colors.blue, width: 2)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      listOfAction(() {
                        navigateTo(const EmergencyContact());
                      }, Icons.phone_callback_outlined, 'Emergency contact'),
                      listOfAction(
                          () {}, Icons.person_3_outlined, 'Personal Details'),
                      listOfAction(() {
                        navigateTo(const UpdatePasswordScreen());
                      }, Icons.settings, 'Update Password'),
                      listOfAction(() {
                        navigateTo(const ChatScreen());
                      }, Icons.question_mark_outlined, 'Help'),
                      listOfAction(() {}, Icons.logout_rounded, 'Logout',
                          bkColor: AppColors.secondary_500Color,
                          iconColor: AppColors.secondaryColor),
                    ],
                  ),
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}

Widget listOfAction(VoidCallback onTap, IconData icon, String text,
    {Color bkColor = AppColors.primary_200Color,
    Color iconColor = AppColors.primary_800Color}) {
  return GestureDetector(
    onTap: onTap,
    child: ListTile(
      leading: Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bkColor,
        ),
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
      title: Text(
        text,
        style: GoogleFonts.openSans(fontSize: 13, color: Colors.black),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        color: AppColors.gray,
      ),
    ),
  );
}
