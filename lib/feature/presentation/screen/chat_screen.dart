import 'package:chattick/config/firebase_setting/firebase.dart';
import 'package:chattick/core/colors.dart';
import 'package:chattick/core/firebase_const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final Map<String, dynamic> userMap;
  final String chatRoomId;

  const ChatScreen({
    super.key,
    required this.userMap,
    required this.chatRoomId,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() async {
    if (_messageController.text.trim().isNotEmpty) {
      final currentUser = FirebaseApi.currentUser;

      final messageData = {
        'message': _messageController.text.trim(),
        'isSender': currentUser?.firstName ?? '',
        'senderUid': firebaseAuth.currentUser?.uid ?? '',
        'time':DateTime.now().millisecondsSinceEpoch,
        'isRead': false,
      };

      try {
        await FirebaseFirestore.instance
            .collection("chatRoom")
            .doc(widget.chatRoomId)
            .collection("chats")
            .add(messageData);

        _messageController.clear();
      } catch (e) {
        print('Error sending message: $e');
      }
    } else {
      print("Please enter a message.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Coloure.BackGround,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Coloure.BackGround,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.userMap["imageUri"]),
            ),
            SizedBox(width: 10),
            Text(widget.userMap["firstName"]),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firestore
                  .collection("chatRoom")
                  .doc(widget.chatRoomId)
                  .collection("chats")
                  .orderBy('time', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No messages yet.'));
                }
                final chatDocs = snapshot.data!.docs;
                return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: chatDocs.length,
                  itemBuilder: (context, index) {
                    final messageData = chatDocs[index].data() as Map<String, dynamic>;
                    final timestamp = messageData['time'];
                    String formattedTime = '';

                    if (timestamp is Timestamp) {
                      // Firestore Timestamp
                      formattedTime = DateFormat('h:mm a').format(timestamp.toDate());
                    } else if (timestamp is int) {
                      // Milliseconds since epoch
                      formattedTime = DateFormat('h:mm a').format(DateTime.fromMillisecondsSinceEpoch(timestamp));
                    } else if (timestamp is String) {
                      // ISO8601 String
                      formattedTime = DateFormat('h:mm a').format(DateTime.parse(timestamp));
                    }
                    return _buildChatBubble(
                      messageData['message'] ?? '',
                      messageData['isSender'] ?? '',
                        formattedTime
                    );
                  },
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildChatBubble(String message, String isSender, String timestamp) {
    bool isCurrentUserSender = FirebaseApi.currentUser?.firstName == isSender;
    //
    // DateTime dateTime = timestamp.toDate();
    // String formattedTime = DateFormat("MMMM d, yyyy 'at' h:mm:ss a z").format(dateTime);

    return Align(
      alignment: isCurrentUserSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isCurrentUserSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            margin: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: isCurrentUserSender ? Colors.blue : Colors.grey[200],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: isCurrentUserSender ? Radius.circular(12) : Radius.zero,
                bottomRight: isCurrentUserSender ? Radius.zero : Radius.circular(12),
              ),
            ),
            child: Text(
              message,
              style: TextStyle(
                color: isCurrentUserSender ? Colors.white : Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              timestamp,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type a message',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
            ),
          ),
          SizedBox(width: 10),
          CircleAvatar(
            backgroundColor: Colors.blue,
            child: IconButton(
              icon: Icon(Icons.send, color: Colors.white),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}

