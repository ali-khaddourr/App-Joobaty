import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1/view/notifications_screen/controller/notifications_controller.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<NotificationsController>(
        init: NotificationsController(),
        builder: (controller) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                  title: Text('Notification $index'),
                  subtitle: Text('Details of the notification.'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
