import 'package:flutter/material.dart';
import 'package:mobi_health/theme.dart';
import 'package:mobi_health/widgets/app_bar.dart';
import 'package:mobi_health/widgets/user_input.dart';
import 'package:mobi_health/widgets/app_buttons.dart';
import 'package:mobi_health/pages/components/app_label.dart';

class EmergencyContact extends StatelessWidget {
  const EmergencyContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: appAppBar('Emergency contact'),
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
                        Text(
                          'Enter an emergency contact we can get to if any issues. This can be your guardian, spouse or fclose friend',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.black),
                        ),
                        const SizedBox(height: 20),
                        const AppLabel(
                            textContent: 'Current emergency contact'),
                        const SizedBox(height: 4),
                        TextInput(
                          textType: TextInputType.number,
                          borderColor: AppColors.grayLight,
                          hintText: '+927 412 9122',
                          inputColor: Colors.black,
                          textInput: TextEditingController(),
                        ),
                        const SizedBox(height: 9),
                        materialButton(
                            buttonBkColor:
                                const Color.fromARGB(255, 189, 189, 189),
                            onPres: () {},
                            text: "Update Contact",
                            textColor: AppColors.gray,
                            width: double.infinity,
                            borderRadiusSize: 5,
                            height: 50),
                      ],
                    ),
                  ),
                ))));
  }
}