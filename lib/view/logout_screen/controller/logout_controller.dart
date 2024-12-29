import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutController extends GetxController{
 Future<void> logOut()async{

   final prefs = await SharedPreferences.getInstance();
   await prefs.clear();

   Get.offAllNamed('/loginScreen');
 }
}