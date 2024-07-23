import 'chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobi_health/theme.dart';
import 'package:mobi_health/svg_assets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobi_health/widgets/app_buttons.dart';
import 'package:mobi_health/widgets/navigations.dart';
import 'package:mobi_health/providers/device_permission_provider.dart';

// bool isSignalClick = false;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
            child: Container(
                // color: Colors.red,
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 70,
                        // color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15, left: 10, right: 10, bottom: 15),
                          child: Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    popScreen();
                                  },
                                  child: const Icon(Icons.arrow_back_rounded)),
                              const SizedBox(width: 15),
                              Image.asset(healthLogoPic),
                              const SizedBox(width: 10),
                              Column(
                                children: [
                                  Text(
                                    'Mubi Care Team',
                                    style: GoogleFonts.openSans(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    'Available at this hour',
                                    style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 55, right: 55),
                          child: context
                                  .watch<DashboardAction>()
                                  .isSignalClickValue
                              ? const EmergencyText()
                              : materialButton(
                                  buttonBkColor: AppColors.secondaryColor,
                                  onPres: () {
                                    setState(() {
                                      context
                                          .read<DashboardAction>()
                                          .buttonValue();
                                    });
                                  },
                                  text: "Signal Emergency",
                                  textColor: AppColors.backgroundColor,
                                  width: double.infinity,
                                  borderRadiusSize: 5,
                                  height: 50)),
                      const SizedBox(
                        height: 10,
                      ),
                      const ChatBox()
                    ],
                  ),
                ))));
  }
}

class EmergencyText extends StatefulWidget {
  const EmergencyText({super.key});

  @override
  State<EmergencyText> createState() => _EmergencyTextState();
}

class _EmergencyTextState extends State<EmergencyText> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(color: Colors.blue, width: 2)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'What is the emergency ?',
              style: GoogleFonts.openSans(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            // SizedBox(height: 5),
            EmergencyInput(
              borderColor: AppColors.secondaryColor,
              hintText: 'Whats your emergency?',
              textInput: TextEditingController(),
              textType: TextInputType.text,
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 25,
              child: Row(
                children: [
                  Checkbox(
                    value: _isSelected,
                    onChanged: (value) {
                      setState(() {
                        _isSelected = value ?? false;
                      });
                    },
                    activeColor: AppColors.secondaryColor,
                    checkColor: AppColors.backgroundColor,
                  ),
                  Text(
                    'Notify my emergency contact',
                    style: GoogleFonts.openSans(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            materialButton(
                buttonBkColor: AppColors.secondaryColor,
                onPres: () {
                  setState(() {
                    context.read<DashboardAction>().buttonValue();
                  });
                },
                size: 14,
                text: "Signal Emergency",
                textColor: AppColors.backgroundColor,
                width: 150,
                borderRadiusSize: 5,
                height: 40)
          ],
        ),
      ),
    );
  }
}

class EmergencyInput extends StatelessWidget {
  final TextEditingController textInput;
  final String hintText;
  final Color borderColor;
  final TextInputType textType;

  const EmergencyInput({
    Key? key,
    required this.textInput,
    required this.hintText,
    required this.borderColor,
    required this.textType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme.titleMedium!.copyWith(
        fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black);
    return SizedBox(
      height: 100,
      child: TextFormField(
        controller: textInput,
        keyboardType: textType,
        style: textStyle,
        maxLines: 3,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: textStyle,
          filled: true,
          fillColor: AppColors.primary50Color,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: borderColor, width: 1.2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: borderColor, width: 1.2),
          ),
        ),
      ),
    );
  }
}