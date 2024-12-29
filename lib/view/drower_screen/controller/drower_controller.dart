
import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/core/service/link.dart';
import 'package:http/http.dart' as http;

class DrowerController extends GetxController {
  var token = ''.obs; // متغير لتخزين التوكن

  @override
  void onInit() {
    super.onInit();
    _loadToken(); // استدعاء الدالة لتحميل التوكن عند التهيئة
  }

  // دالة لتحميل التوكن من SharedPreferences
  Future<void> _loadToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString('token') ?? ''; // Update observable token
    // print('88888888888888888888888888888888${token.value}88888888888888888888888888888');
    update(); // Notify observers
  }

  Future<void> deleteProfile() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      // استخدم Uri.parse لرابط API
      final uri = Uri.parse('${AppLink.deleteuser}');

      // إرسال الطلب لحذف الحساب
      final response = await http.delete(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // حذف التوكين
        await prefs.remove('token');

        Get.offAllNamed('/home'); // استبدل '/home' بالمسار الصحيح للصفحة الرئيسية

        Get.snackbar('Success', 'Account deleted successfully!');
      } else {
        print('${response.body}');
      }
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
  }

  // دالة الانتقال إلى صفحة محددة
  void navigateToPage(String routeName) {
    Get.toNamed(routeName);
  }
}
