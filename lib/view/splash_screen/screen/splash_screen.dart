import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1/core/const_data/app_colors.dart';
import 'package:test1/core/const_data/my_size.dart';
import 'package:test1/view/splash_screen/controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final splashController = Get.put(SplashController());

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // عرض الشعار بدون تأثيرات
            Image.asset(
              'assets/images/jp_logo.png',
              width: 200,
              height: 200,
            ),
            SizedBox(height: MySize.md),
            // زر "Loading"
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            ), // يمكنك استخدام أي عنصر loading آخر تفضله
            SizedBox(height: MySize.md),
            Text(
              'Loading...',
              style: TextStyle(
                color: AppColors.black,
                fontSize: MySize.fontSizeMd,
              ),
            ),
          ],
        ),
      ),
    );
  }
}