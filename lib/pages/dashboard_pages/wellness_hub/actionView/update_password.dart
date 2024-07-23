import 'package:flutter/material.dart';
import 'package:mobi_health/theme.dart';
import 'package:mobi_health/widgets/app_bar.dart';
import 'package:mobi_health/widgets/user_input.dart';
import 'package:mobi_health/widgets/app_buttons.dart';
import 'package:mobi_health/pages/components/app_label.dart';

class UpdatePasswordScreen extends StatelessWidget {
  const UpdatePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: appAppBar('Update Password'),
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppLabel(textContent: 'Current Password'),
                const SizedBox(height: 3),
                TextInput(
                  textType: TextInputType.text,
                  borderColor: AppColors.grayLight,
                  hintText: 'John',
                  inputColor: Colors.black,
                  textInput: TextEditingController(),
                ),
                const SizedBox(height: 13),
                const AppLabel(textContent: 'New Password'),
                const SizedBox(height: 3),
                TextInput(
                  textType: TextInputType.text,
                  borderColor: AppColors.grayLight,
                  hintText: '@John123',
                  inputColor: Colors.black,
                  textInput: TextEditingController(),
                ),
                const SizedBox(height: 13),
                const AppLabel(textContent: 'Confirm Password'),
                const SizedBox(height: 3),
                TextInput(
                  textType: TextInputType.text,
                  borderColor: AppColors.grayLight,
                  hintText: '@John123',
                  inputColor: Colors.black,
                  textInput: TextEditingController(),
                ),
                const SizedBox(height: 15),
                materialButton(
                    buttonBkColor: const Color.fromARGB(255, 189, 189, 189),
                    onPres: () {},
                    text: "Update Password",
                    textColor: AppColors.gray,
                    width: double.infinity,
                    borderRadiusSize: 5,
                    height: 50),
              ],
            ),
          ),
        ),
      )),
    );
  }
}