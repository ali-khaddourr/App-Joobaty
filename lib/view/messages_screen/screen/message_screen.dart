import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1/view/findjobs_screen/screen/find_jobs_screen.dart';
import 'package:test1/view/messages_screen/controller/messages_controller.dart';
import 'package:test1/view/messages_screen/screen/messages_screen.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages_title'.tr),
      ),
      body: GetBuilder<MessagesController>(
        init: MessagesController(),
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: controller.conversations.isEmpty
                ? Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          'https://cdn-icons-png.flaticon.com/512/2665/2665038.png',
                          // استبدل هذا بالرابط الخاص بالصورة الافتراضية
                          width: double.infinity,
                          height: 200,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'message1'.tr,
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          'message2'.tr,
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            Get.off(FindJobsScreen());
                          },
                          child: Text('find_jobs'.tr),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      DropdownButtonFormField<String>(
                        value: controller.selectedBox,
                        onChanged: (String? value) {
                          if (value != null) {
                            controller.updatechange(value);
                          }
                        },
                        items: controller.dropdownMenuItems,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.conversations.length,
                          itemBuilder: (context, index) {
                            var conversation = controller.conversations[index];
                            return GestureDetector(
                              onTap: () {
                                // جلب المحادثة الخاصة بالمستخدم عند النقر
                                controller
                                    .fetchUserConversation(
                                        conversation['user']['id'])
                                    .then((_) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MessagesScreen(
                                        userId: conversation['user']['id'],
                                        userName: conversation['user']['name'],
                                      ),
                                    ),
                                  );
                                });
                              },
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      'https://www.jobaaty.com/public/sitesetting_images/thumb/jobaaty-1724577087-331.png'),
                                ),
                                title: Text(conversation['user']['name']),
                                subtitle: Text(conversation['message']),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
