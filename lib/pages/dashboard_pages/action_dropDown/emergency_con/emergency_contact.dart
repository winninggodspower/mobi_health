import '../export_action_drop_down.dart';

class EmergencyContact extends StatelessWidget {
  const EmergencyContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: appAppBar('Emergency contact'),
        body: SafeArea(
            child: SizedBox(
                width: 100.w,
                height: 100.h,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Enter an emergency contact we can get to if any issues. This can be your guardian, spouse or fclose friend',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 2.h),
                        const AppLabel(
                            textContent: 'Current emergency contact'),
                        SizedBox(height: 1.h),
                        TextInput(
                          textType: TextInputType.number,
                          borderColor: AppColors.grayLight,
                          hintText: '+927 412 9122',
                          inputColor: Colors.black,
                          textInput: TextEditingController(),
                        ),
                        SizedBox(height: 5.h),
                        materialButton(
                            buttonBkColor:
                                const Color.fromARGB(255, 189, 189, 189),
                            onPres: () {},
                            text: "Update Contact",
                            textColor: AppColors.gray,
                            width: 100.w,
                            borderRadiusSize: 5,
                            height: 7.h),
                      ],
                    ),
                  ),
                ))));
  }
}
