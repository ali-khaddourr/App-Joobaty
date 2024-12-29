import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/controllers/app_configuration.dart';
import 'package:test1/core/service/link.dart';
import 'package:test1/model/currency.dart';
import 'package:test1/view/findjobs_screen/controller/find_jobs_controller.dart';
import 'package:http/http.dart' as http;
import 'package:test1/view/findjobs_screen/screen/find_jobs_screen.dart';

class ApplyPopupContent extends StatelessWidget {
  final String slug;

  ApplyPopupContent({required this.slug});

  final TextEditingController currentSalaryController = TextEditingController();
  final TextEditingController expectedSalaryController = TextEditingController();
  Currency? selectedCurrency;
  Map<String, dynamic>? selectedCv;

  @override
  Widget build(BuildContext context) {
    final FindJobsController jobsController = Get.find<FindJobsController>();
    final AppConfigurationController configController = Get.find<AppConfigurationController>();

    return Container(
      width: 500,
      height: 300,
      child: Column(
        children: [
          Obx(() {
            return Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    // تجربة جلب الـ CV عند الضغط
                    await jobsController.fetchCv();
                  },
                  child: DropdownButton<dynamic>(
                    hint: Text('Select CV'),
                    value: selectedCv,
                    items: jobsController.profileCv.map((cv) {
                      return DropdownMenuItem<dynamic>(
                        value: cv,
                        child: Text(cv['title'] ?? 'CV Title'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      // تعيين القيمة الجديدة
                      selectedCv = value;
                      Get.forceAppUpdate();
                    },
                  ),
                ),
                if (selectedCv != null)
                  Text('Selected CV: ${selectedCv!['title']}', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            );
          }),
          TextField(
            controller: currentSalaryController,
            decoration: InputDecoration(labelText: 'Current Salary'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: expectedSalaryController,
            decoration: InputDecoration(labelText: 'Expected Salary'),
            keyboardType: TextInputType.number,
          ),
          Obx(() {
            return Column(
              children: [
                DropdownButton<Currency>(
                  hint: Text('Select Currency'),
                  value: selectedCurrency, // تعيين القيمة الحالية
                  items: configController.currencies.map((currency) {
                    return DropdownMenuItem<Currency>(
                      value: currency,
                      child: Text(currency.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedCurrency = value;
                    Get.forceAppUpdate(); // تحديث الواجهة
                  },
                ),
                if (selectedCurrency != null)
                  Text('Selected Currency: ${selectedCurrency!.name}', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            );
          }),
          ElevatedButton(
            onPressed: () async {
              await submitApplication(slug);
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  Future<void> submitApplication(String slug) async {
    final url = Uri.parse('${AppLink.submitapplyNow}/$slug');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: {
        "cv_id": selectedCv?['id'].toString(),
        "current_salary": currentSalaryController.text,
        "expected_salary": expectedSalaryController.text,
        "salary_currency": selectedCurrency?.id.toString(),
      },
    );

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Application submitted successfully!');
      Get.off(FindJobsScreen());
    } else {
      print('Error');
      Get.snackbar('Error', 'Failed to submit application: ${response.body}');
    }
  }
}
