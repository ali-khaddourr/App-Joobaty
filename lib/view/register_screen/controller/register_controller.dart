import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/core/service/link.dart';
import 'package:test1/view/home_screen/screen/home_screen.dart';
import 'package:test1/view/login_screen/screen/login_screen.dart';
import 'package:test1/view/logout_screen/screen/logout_screen.dart';

class RegisterController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController middelNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  PhoneController phoneController = PhoneController();
  TextEditingController confirmPasswordController = TextEditingController();
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

  var isPasswordVisible = false.obs; // متغير لرؤية كلمة المرور

  // تابع للتحقق من كلمة المرور

  // تغيير رؤية كلمة المرور
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  String? verificationId;
  var isLoading = false.obs;

  // Send OTP to the user's phone number using Firebase
  Future<void> sendOtp(String phoneNumber) async {
    if (formKey.currentState?.validate() ?? false) {
      isLoading.value = true;
      try {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          timeout: const Duration(seconds: 60),
          verificationCompleted: (PhoneAuthCredential credential) async {
            // Auto-retrieval or auto-verification complete
            await FirebaseAuth.instance.signInWithCredential(credential);
            Get.off(LoginScreen());
          },
          verificationFailed: (FirebaseAuthException e) {
            Get.snackbar('Error', 'Failed to verify phone number');
            isLoading.value = false;
          },
          codeSent: (String verId, int? resendToken) {
            verificationId = verId;
            isLoading.value = false;
            Get.dialog(_buildOtpDialog()); // Show OTP input dialog
          },
          codeAutoRetrievalTimeout: (String verId) {
            verificationId = verId;
            isLoading.value = false;
          },
        );
      } catch (e) {
        Get.snackbar('Error', 'Failed to send OTP');
        isLoading.value = false;
      }
    }
    else{
      Get.snackbar('Error', 'Failed to sign up');

    }
  }

  // Verify OTP input
  Future<void> verifyOtp(String otp) async {
    isLoading.value = true;
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: otp,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      Get.off(LoginScreen());
    } catch (e) {
      Get.snackbar('Error', 'Invalid OTP');
      isLoading.value = false;
    }
  }

  Future<void> signup(
      String email,
      String password,
      String conPassword,
      String phone,
      String firstName,
      String lastName,
      String middleName) async {
    if (formKey.currentState?.validate() ?? false) {
      final url = Uri.parse(AppLink.signUp);
      final response = await http.post(
        url,
        body: {
          'email': email,
          'password': password,
          'password_confirmation': conPassword,
          'phone': phone,
          'first_name': firstName,
          'middle_name': middleName,
          'last_name': lastName,
        },
        headers: {'Accept': 'application/json'},
      );
      print(response.statusCode);

      if (response.statusCode == 201) {
        await signIn(email, password, phone);
      } else {

        print(response.body);
        Get.snackbar('Error', response.body);
      }
    }
  }

  Future<void> signIn(String email, String password, String phone) async {
    if (formKey.currentState?.validate() ?? false) {
      final url = Uri.parse(AppLink.login);

      // إعداد الجسم بناءً على ما إذا كان البريد الإلكتروني فارغًا أم لا
      Map<String, String> body;
      if (email.isEmpty) {
        body = {'password': password, 'phone': phone};
      } else {
        body = {'email': email, 'password': password, 'phone': phone};
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

  // Build the OTP dialog
  Widget _buildOtpDialog() {
    return AlertDialog(
      title: Text("Enter OTP"),
      content: TextFormField(
        controller: otpController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(hintText: 'Enter OTP'),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            await verifyOtp(otpController.text);
          },
          child: Text("Verify"),
        ),
      ],
    );
  }

  String? nameValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? passwordValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
  String? confirmPasswordValidator(String value) {
    if (value.isEmpty) {
      return 'Please confirm your password';
    } else if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

}
