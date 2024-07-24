import 'dart:ffi';

import 'chat_widget.dart';
import '../action_dropDown/export_action_drop_down.dart';
import 'package:mobi_health/svg_assets.dart';


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
        // bottomNavigationBar: ,
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
                      const    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ChatBubble(
                              isMe: true,
                              message: 'hey i\'m sick what do you want to do about it dfad dfasdf dfasdf asdfas',
                              ),
                            SizedBox(height: 20,),
                            ChatBubble(
                              message: 'hey i\'m sick what do you want to do about it dfad dfasdf dfasdf asdfas',
                              ),
                          ],
                        ),
                      ),
                      const ChatBox()
                    ],
                  ),
                ))));
  }
}

class ChatBubble extends StatelessWidget {
  final bool isMe;
  final String message;

  const ChatBubble({
    super.key,
    required this.message,
    this.isMe = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth * 0.7;
        return Row(
          mainAxisAlignment: isMe ? MainAxisAlignment.end: MainAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: maxWidth, // Set the maximum width to 70% of the screen width
              ),
              decoration: BoxDecoration(
                color: AppColors.primary_200Color,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 8),
              child: Text(
                message,
                softWrap: true,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(
                      fontSize: 14,
                      color: AppColors.primary_800Color,
                      fontWeight: FontWeight.w700,
                    ),
                textAlign: isMe? TextAlign.end: TextAlign.start,
              ),
            ),
          ],
        );
      }
    );
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