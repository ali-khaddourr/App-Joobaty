import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1/view/messages_screen/controller/messages_controller.dart';
import 'package:file_picker/file_picker.dart';

class MessagesScreen extends StatelessWidget {
  final int userId;
  final String userName;

  const MessagesScreen({super.key, required this.userId, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChatPage(userId: userId, userName: userName),
    );
  }
}

class ChatPage extends StatelessWidget {
  final int userId;
  final String userName;
  bool isLoading = false; // متغير لتحديد حالة التحميل

  ChatPage({required this.userId, required this.userName});

  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(userName),
        actions: [
          Icon(Icons.group),
          SizedBox(width: 10),
        ],
      ),
      body: GetBuilder<MessagesController>(
        init: MessagesController(),
        builder: (controller) {
          controller.startTimer(userId); // استدعاء الدالة مع userId
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: controller.userConversation['conversations']?.length ?? 0,
                  itemBuilder: (context, index) {
                    var message = controller.userConversation['conversations'][index];
                    bool isSentByMe = message['to_id'] == userId.toString();
                    return _buildMessageItem(message, isSentByMe);
                  },
                ),
              ),
              _buildInputField(controller),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMessageItem(var message, bool isSentByMe) {
    bool hasAttachment = message['message_type'] != 0; // تحقق إذا كان النوع ليس 0

    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSentByMe ? Colors.blue[200] : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              isSentByMe ? 'أنا' : message['sender']['name'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            if (hasAttachment)
              _buildFileIcon(message['message']),
            if (!hasAttachment)
              Text(message['message']),
            SizedBox(height: 5),
            Text(
              message['created_at'],
              style: TextStyle(fontSize: 10, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileIcon(String attachment) {
    String fileExtension = attachment.split('.').last.toLowerCase();
    IconData fileIcon;

    switch (fileExtension) {
      case 'pdf':
        fileIcon = Icons.picture_as_pdf;
        break;
      case 'doc':
      case 'docx':
        fileIcon = Icons.description;
        break;
      case 'png':
      case 'jpg':
      case 'jpeg':
        fileIcon = Icons.image;
        break;
      default:
        fileIcon = Icons.insert_drive_file;
    }

    return Row(
      children: [
        Icon(fileIcon),
        SizedBox(width: 5),
        Expanded(  // استخدام Expanded هنا
          child: Text(
            attachment.split('/').last,
            style: TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis, // إضافة هذا للسماح بالقص إذا كانت النصوص طويلة
          ),
        ),
      ],
    );
  }

  Widget _buildInputField(MessagesController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.attach_file),
            onPressed: () async {
              final controller = Get.find<MessagesController>();
              await controller.uploadFileAndSendMessage(userId);
            },
          ),
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: 'اكتب رسالتك',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () async {
              await controller.sendMessage(userId.toString(), messageController.text);
              await controller.fetchUserConversation(userId);
              messageController.clear();
              controller.update();
            },
          ),
        ],
      ),
    );
  }
}
