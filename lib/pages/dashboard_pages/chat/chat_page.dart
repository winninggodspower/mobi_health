import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobi_health/pages/dashboard_pages/action_dropDown/export_action_drop_down.dart';
import 'package:mobi_health/providers/authentication_provider.dart';
import 'package:mobi_health/svg_assets.dart' as svg_assets;
import 'dart:developer' as developer;
import 'package:mobi_health/pages/dashboard_pages/chat/chat_buble.dart';
import 'package:rxdart/rxdart.dart';

class ChatPage extends StatefulWidget {
  final String receiverId;
  final String receiverType;
  String receiverName;

  ChatPage({
    super.key,
    required this.receiverId, 
    required this.receiverType,
    this.receiverName = 'unknown',
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }


  Stream<List<Map<String, dynamic>>> fetchAndCombineMessages(String currentUserId, String receiverId) {
    var sentMessagesStream = FirebaseFirestore.instance
        .collection('chats')
        .where('senderId', isEqualTo: currentUserId)
        .where('receiverId', isEqualTo: receiverId)
        .snapshots();

    var receivedMessagesStream = FirebaseFirestore.instance
        .collection('chats')
        .where('receiverId', isEqualTo: currentUserId)
        .where('senderId', isEqualTo: receiverId)
        .snapshots();

    return CombineLatestStream.combine2(
      sentMessagesStream,
      receivedMessagesStream,
      (QuerySnapshot sentSnapshot, QuerySnapshot receivedSnapshot) {
        var sentMessages = sentSnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
        var receivedMessages = receivedSnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

        var allMessages = [...sentMessages, ...receivedMessages];

        // Sort messages by timestamp
        allMessages.sort((a, b) {
          final timestampA = a['timestamp'];
          final timestampB = b['timestamp'];
          if (timestampA == null || timestampB == null) {
            return 0; 
          }
          return (timestampA as Timestamp).compareTo(timestampB as Timestamp);
        });

        return allMessages;
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: <Widget>[
                IconButton(
                  onPressed: (){
                     Navigator. of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_rounded)
                ),
                Expanded(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: Image.asset(svg_assets.healthLogoPic),
                    title: Text(
                      widget.receiverName,
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        color: AppColors.gray900,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      'Available at this hour',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                )
              ]
            ),
            // ListView(),
           Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: _buildMessageList(),
                )
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.primary_300Color,
                    borderRadius: BorderRadius.circular(45),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: InputDecoration(
                            hintText: 'Type your message...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(45),
                            ),
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                          onSubmitted: (text) {
                            if(text.isNotEmpty){
                              _submitMessage();
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: Icon(Icons.send, color: const Color(0xff1B72C0), size: 20),
                        onPressed: () {
                         if(_messageController.text.isNotEmpty){
                            _submitMessage();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              )
            )
          ],
        )
      ),
    );
  }

  Widget _buildMessageList(){
    final authProvider = context.read<AuthenticationProvider>();
    final currentUserId = authProvider.user?.uid;

    return StreamBuilder(
      stream: fetchAndCombineMessages(currentUserId!, widget.receiverId),
      builder: (context, snapshot){
          if(snapshot.hasError){
            return Text('Error${snapshot.error}');
          }else{
            return Column(
              children: snapshot.data!.map((document){
                return Column(children: [
                  ChatBubble(message: document['content'], isMe: authProvider.user?.uid == document['senderId']),
                  const SizedBox(height: 20),
                ],);
              }).toList(),
            );
          }
        },
      );
  }

  Future<void> _submitMessage() async {
    final authProvider = context.read<AuthenticationProvider>();
    final currentUserId = authProvider.user?.uid;
    final messageContent = _messageController.text.trim();

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