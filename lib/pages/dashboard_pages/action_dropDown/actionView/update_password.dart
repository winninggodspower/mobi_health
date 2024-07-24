import '../export_action_drop_down.dart';

class UpdatePasswordScreen extends StatelessWidget {
  const UpdatePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: appAppBar('Update Password'),
      body: SafeArea(
          child: SizedBox(
        width: 100.w,
        height: 100.h,
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppLabel(textContent: 'Current Password'),
                 SizedBox(height: 1.h),
                TextInput(
                  textType: TextInputType.text,
                  borderColor: AppColors.grayLight,
                  hintText: 'John',
                  inputColor: Colors.black,
                  textInput: TextEditingController(),
                ),
                 SizedBox(height: 2.h),
                const AppLabel(textContent: 'New Password'),
                 SizedBox(height: 1.h),
                TextInput(
                  textType: TextInputType.text,
                  borderColor: AppColors.grayLight,
                  hintText: '@John123',
                  inputColor: Colors.black,
                  textInput: TextEditingController(),
                ),
                 SizedBox(height: 2.h),
                const AppLabel(textContent: 'Confirm Password'),
                 SizedBox(height: 1.h),
                TextInput(
                  textType: TextInputType.text,
                  borderColor: AppColors.grayLight,
                  hintText: '@John123',
                  inputColor: Colors.black,
                  textInput: TextEditingController(),
                ),
                 SizedBox(height: 4.h),
                materialButton(
                    buttonBkColor: const Color.fromARGB(255, 189, 189, 189),
                    onPres: () {},
                    text: "Update Password",
                    textColor: AppColors.gray,
                    width: 100.w,
                    borderRadiusSize: 5,
                    height: 7.h),
              ],
            ),
          ),
        ),
      )),
    );
  }
}