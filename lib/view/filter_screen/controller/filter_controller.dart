import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test1/controllers/app_configuration.dart';
import 'package:test1/core/service/app_configuration_service.dart';
import 'package:test1/model/gender.dart';

class FilterController extends GetxController{
  RxList<int> selectedGenderIds = <int>[].obs;
  RxList<Gender> selectedGenders = <Gender>[].obs;
  RxList<Gender> genders = <Gender>[].obs;
  TextEditingController fromSalary = TextEditingController();
  TextEditingController toSalary = TextEditingController();

  void toggleGrnderSelection(Gender gender) {
    if (selectedGenders.contains(gender)) {
      selectedGenders.remove(gender);
    } else {
      selectedGenders.add(gender);
    }
    // تحديث معرفات الدول المختارة
    selectedGenderIds.value = selectedGenders.map((gender) => gender.id).toList();

    // تحديث الواجهة بعد الانتهاء من كل شيء
    update();
  }

  getInfoGender(){
    var controllerCon = Get.put(AppConfigurationController());
    genders.value = controllerCon.genders;
  }

  bool isLoading = false;
@override
  void onInit() {
  isLoading = true;
  getInfoGender();
  isLoading = false;

  // TODO: implement onInit
    super.onInit();
  }


}