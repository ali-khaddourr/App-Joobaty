import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/view/home_screen/screen/home_screen.dart';
import 'package:test1/view/login_screen/screen/login_screen.dart';

class SplashController extends GetxController with SingleGetTickerProviderMixin {
  late AnimationController animationController;
  RxDouble logoFadeAnimation = 0.0.obs; // للتحكم في شفافية اللوغو
  RxDouble logoScaleAnimation = 0.5.obs; // للتحكم في حجم اللوغو
  RxDouble textFadeAnimation = 0.0.obs; // للتحكم في شفافية النص
  RxDouble textWaveAnimation = 0.0.obs; // للتحكم في تأثير التموجات

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    // تشغيل الرسوم المتحركة
    Future.delayed(const Duration(milliseconds: 500), () {
      logoFadeAnimation.value = 1.0; // ظهور اللوغو
      logoScaleAnimation.value = 1.0; // الحجم الطبيعي للوغو
    });

    // جعل اللوغو يختفي
    Future.delayed(const Duration(seconds: 3), () {
      logoFadeAnimation.value = 0.0; // اختفاء اللوغو
    });

    // جعل اللوغو يظهر مرة أخرى بحجم أكبر
    Future.delayed(const Duration(seconds: 4), () {
      logoFadeAnimation.value = 1.0; // ظهور اللوغو مرة أخرى
      logoScaleAnimation.value = 1.5; // زيادة الحجم
    });

    // ظهور النص مع تأثير تموجات
    Future.delayed(const Duration(seconds: 5), () {
      textFadeAnimation.value = 1.0; // ظهور النص
      textWaveAnimation.value = 20.0; // تحريك النص لأعلى (قيمة تموجات)
    });

    // الانتقال إلى الشاشة التالية بعد فترة
    Timer(const Duration(seconds: 7), () async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token != null) {
        Get.off(() => HomeScreen());
      } else {
        Get.off(() => LoginScreen());
      }
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
