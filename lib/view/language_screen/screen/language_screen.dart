import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1/core/const_data/my_size.dart';
import 'package:test1/lang/language_controller.dart';
import 'package:test1/view/home_screen/controller/home_controller.dart'; // استيراد الـ HomeController

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>(); // الحصول على HomeController

    return Scaffold(
      appBar: AppBar(
        title: Text('choose_your_language'.tr, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      body: GetBuilder<LanguageController>(
        init: LanguageController(),
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(MySize.la),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'choose_your_language'.tr,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red, width: 2),
                  ),
                  child: DropdownButton<String>(
                    dropdownColor: Colors.white,
                    value: controller.savedLang.value,
                    icon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_downward, size: 24, color: Colors.red),
                    ),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    underline: SizedBox(),
                    onChanged: (String? newValue) {
                      controller.savedLang.value = newValue!;
                      Get.updateLocale(Locale(newValue.toLowerCase()));
                      controller.saveLocal();

                      // استدعاء دالة fetchBlogs عند تغيير اللغة
                      homeController.fetchBlogs();
                    },
                    items: <String>['EN', 'AR']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
