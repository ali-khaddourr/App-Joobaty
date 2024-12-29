import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1/lang/pref_service.dart';



class LanguageController extends GetxController {
  final PrefService _prefService = PrefService();
  var savedLang = 'EN'.obs;
  saveLocal(){
    _prefService.createString('locale', savedLang.value);
  }

  Future<void> setLocale()async{
    _prefService.readString('locale').then((value) {
      if(value != '' && value != null){
        Get.updateLocale(Locale(value.toString().toLowerCase()));
        savedLang.value=value.toString();
        // update();
      }
    });
  }
  @override
  void onInit() async{
    setLocale();
    // TODO: implement onInit
    super.onInit();
  }
}
