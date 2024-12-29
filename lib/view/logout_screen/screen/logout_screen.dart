import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1/core/const_data/my_size.dart';
import 'package:test1/view/logout_screen/controller/logout_controller.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('logout'.tr),
      ),
      body: GetBuilder(
      init: LogoutController(),
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.logout,
                  size: 100,
                  color: Colors.red,
                ),
                SizedBox(height: 20),
                Text(
                  'are_you_sure'.tr,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'you_will'.tr,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    controller.logOut();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // لون الزر
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'logout'.tr,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                SizedBox(height: MySize.md),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'cancel'.tr,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
