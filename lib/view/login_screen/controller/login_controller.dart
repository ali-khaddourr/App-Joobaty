import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:phone_form_field/phone_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/core/const_data/const_data.dart';
import 'package:test1/core/service/link.dart';
import 'package:test1/view/home_screen/screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {

 var isPhoneLogin = false.obs;
 var isEmailLogin = false.obs; // Add this line
 // var isPasswordLogin = false.obs; // Add this line
 // var isContinueLogin = false.obs; // Add this line
 // var isBackLogin = false.obs; // Add this line
 // var isPhoneEmailLogin = false.obs;

 // void togglePhoneEmailLoginMethod() {
 //  isPhoneEmailLogin.value = !isPhoneEmailLogin.value;
 //  update();
 // }
 void togglePhoneLoginMethod() {
  isPhoneLogin.value = !isPhoneLogin.value;
  update();
 }
 void toggleEmailLoginMethod() {
  isEmailLogin.value = !isEmailLogin.value;
  update();
 }
 // void toggleContinueLoginMethod() {
 //  isContinueLogin.value = !isContinueLogin.value;
 //  update();
 // }
 //
 // void toggleBackLoginMethod() {
 //  isBackLogin.value = !isBackLogin.value;
 //  update();
 // }
 // void togglePasswordLoginMethod() {
 //  isPasswordLogin.value = !isPasswordLogin.value;
 //  update();
 // }

 TextEditingController emailController = TextEditingController();
 TextEditingController passwordController = TextEditingController();
 PhoneController phoneController = PhoneController();

 TextEditingController otpController = TextEditingController();

 final GlobalKey<FormState> formKey = GlobalKey<FormState>();

 String? emailValidator(String value) {
  if (value.isEmpty) {
   return 'Please enter your email';
  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
   return 'Please enter a valid email';
  }
  return null;
 }

 var isPasswordVisible = false.obs;
 var isLoading = false.obs;

 void togglePasswordVisibility() {
  isPasswordVisible.value = !isPasswordVisible.value;
 }

 Future<void> signIn(String email, String password, PhoneNumber phone) async {
   String formattedPhone = '+${phone.countryCode}${phone.nsn}';
   final url = Uri.parse(AppLink.login);

   // إعداد الجسم بناءً على ما إذا كان البريد الإلكتروني فارغًا أم لا
   Map<String, String> body;
   if (email.isEmpty) {
    body = {'password': password, 'phone': formattedPhone};
   } else {
    body = {'email': email, 'password': password, 'phone': formattedPhone};
   }

   final response = await http.post(
    url,
    body: body,
    headers: {'Accept': 'application/json'},
   );

   print('Request body: ${jsonEncode(body)}');
   print('Response: ${response.body}');

   if (response.statusCode == 200) {
    final decodeResponse = jsonDecode(response.body);
    final prefs = await SharedPreferences.getInstance();
    final token = decodeResponse['token'];
    final id = decodeResponse['user']['id'];
    await prefs.clear();
    if (token != null) {
     await prefs.setString('token', token);
     print('Token stored: $token');
    }
    await prefs.setInt('user_id', id);
    final userToken = decodeResponse['user']['token'];
    if (userToken != null) {
     await prefs.setString('user_token', userToken);
    }
    Get.off(HomeScreen());
   } else {
    Get.snackbar('Error', response.body);
   }

 }


}
