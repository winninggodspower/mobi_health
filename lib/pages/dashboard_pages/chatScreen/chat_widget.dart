import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobi_health/providers/authentication_provider.dart';

import '../action_dropDown/export_action_drop_down.dart';




class ChatBox extends StatefulWidget {
   final String receiverId;
  final String receiverType;

  const ChatBox({
    super.key,
    required this.receiverId, 
    required this.receiverType,
  });

  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _messageController = TextEditingController();
  
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
                  height: 8.h,
                  margin:  EdgeInsets.only(left: 5.w, right: 5.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColors.primary_200Color),
                  child: Form(
                    key: _formKey,
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
                        Container(
                          width: 55.w,
                          height: 6.h,
                          child: TextFormField(
                            controller: _messageController,
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
                        ),
                        SizedBox(width: 2.w),
                        IconButton(
                          onPressed: (){
                    
                          },
                          icon: const Icon(
                            Icons.send_outlined,
                            color: AppColors.primary_600Color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 1.h,)
              ],
            ),
          ),
        ));
  }

  Future<void> _submitMessage() async {
    final authProvider = context.read<AuthenticationProvider>();
    final currentUserId = authProvider.user?.uid;
    final messageContent = _messageController.text.trim();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (messageContent.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection('chats').add({
          'senderId': currentUserId,
          'receiverId': widget.receiverId,
          'content': messageContent,
          'timestamp': FieldValue.serverTimestamp(),
          'senderType': authProvider.userInfo?['userType'],
          'receiverType': widget.receiverType,
        });

        // Clear the message input field
        _messageController.clear();

        // // Optionally, refresh the messages
        // setState(() {
        //   // _messagesFuture = _fetchAndCombineMessages(currentUserId!, widget.receiverId);
        // });
      } catch (e) {
        // Handle errors (e.g., show a snack bar or log the error)
        print("Error submitting message: $e");
      }
    }
  }
}


