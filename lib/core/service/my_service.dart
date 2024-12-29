import 'dart:async';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyService extends GetxService {

 static late SharedPreferences sharedpereference;

  Future<MyService> init() async {
    sharedpereference = await SharedPreferences.getInstance();
    return this;
  }
}

initialServices() async {
  await Get.putAsync(() => MyService().init());
}
