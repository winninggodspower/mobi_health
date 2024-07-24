import '../export_action_drop_down.dart';




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
        height: context.watch<DashboardAction>().isSignalClickValue ? 48.h : 78.h,
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
                  height: 8.h,
                  margin:  EdgeInsets.only(left: 5.w, right: 5.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColors.primary_200Color),
                  child: Row(
                    children: [
                      Container(
                        // color: Colors.pink,
                        width: 21.w,
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
                      SizedBox(width: 2.w),
                      const Icon(
                        Icons.send_outlined,
                        color: AppColors.primary_600Color,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 1.h,)
              ],
            ),
          ),
        ));
  }
}

Container chatInput() {
  return Container(
    width: 55.w,
    height: 6.h,
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