import 'package:flutter/material.dart';
import 'package:mobi_health/theme.dart';
import 'package:provider/provider.dart';
import 'package:mobi_health/providers/device_permission_provider.dart';

class ChatBox extends StatefulWidget {
  const ChatBox({super.key});

  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: context.watch<DashboardAction>().isSignalClickValue ? 350 : 560,
        // color: const Color.fromARGB(255, 110, 23, 23),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  color: const Color.fromARGB(255, 70, 244, 54),
                  // here will display the chat
                ),
                Container(
                  width: double.infinity,
                  height: 60,
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColors.primary_200Color),
                  child: Row(
                    children: [
                      Container(
                        // color: Colors.pink,
                        width: 90,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.camera_enhance,
                              color: AppColors.primary_600Color,
                            ),
                            Icon(
                              Icons.image_rounded,
                              color: AppColors.primary_600Color,
                            )
                          ],
                        ),
                      ),
                      chatInput(),
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.send_outlined,
                        color: AppColors.primary_600Color,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

Container chatInput() {
  return Container(
    width: 200,
    height: 48,
    child: TextFormField(
      controller: TextEditingController(),
      maxLines: 1,
      decoration: InputDecoration(
        hintText: 'Text',
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.white)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.white)),
      ),
    ),
  );
}
