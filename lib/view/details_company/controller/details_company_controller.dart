import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/core/service/link.dart';

class DetailsCompanyController extends GetxController{

String? selectJob;
String? selectLocation;
String? selectLanguage;
double rating = 3.5;
var Companies = <Map<String, dynamic>>[].obs;
var companyDetails = <String, dynamic>{}.obs;
var isLoading = true.obs;
List dataJobs = [];
bool isLoadingJob = false;

@override
void onInit() {
  super.onInit();
  fetchcompanies();
  fetchData();// استدعاء الدالة لتحميل البيانات
}

Future<void> fetchcompanies() async {
  try {
    final response = await http.get(Uri.parse('${AppLink.companies}'));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['data'] is List) {
        Companies.value = List<Map<String, dynamic>>.from(jsonResponse['data']);
      } else {
        throw Exception('Data format is not correct');
      }
      print(Companies.value);
    } else {
      throw Exception('Failed to load companies');
    }
  } catch (e) {
    print(e);
  } finally {
    isLoading.value = false; // تغيير حالة التحميل
  }
}

Future<void> fetchCompanyDetails(String slug) async {
  try {
    final response = await http.get(Uri.parse('${AppLink.companiesDetails}/$slug'));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['company'] != null) {
        // قم بتخزين بيانات الشركة كخريطة
        companyDetails.value = jsonResponse['company'] as Map<String, dynamic>;
      } else {
        throw Exception('Data format is not correct');
      }
    } else {
      throw Exception('Failed to load company details');
    }
  } catch (e) {
    print(e);
  }
}

Future<void> fetchData({
  List<int>? companyId, // تغيير هنا لقائمة من المعرفات
}) async {
  isLoadingJob = true;
  update();
  try {
    final uri = Uri.parse('${AppLink.jobSearch}').replace(queryParameters: {
      'company_id[]': companyId?.join(','),
    });
    final response = await http.get(uri, headers: {'Accept': 'application/json'});
    if (response.statusCode == 200) {
      final decodeResponse = json.decode(response.body);
      final dataList = decodeResponse['jobs']['data'] as List<dynamic>;
      dataJobs = dataList;
      print('after fetch');
      print(dataList);
      isLoadingJob = false;
      update();

    }
  } catch (e) {
    print('Failed to load data: $e');
  }
}

Map<String, dynamic>? detailsJobData;

Future<void> detailsJob(String jobSlug) async {
  try {
    final url = Uri.parse('${AppLink.detaileJobs}/$jobSlug');
    final response = await http.get(url, headers: {'Accept': 'application/json'});

    if (response.statusCode == 200) {
      final decodeResponse = json.decode(response.body);
      detailsJobData = decodeResponse;
      update();
    } else {
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    print('Failed to load data: $e');
  }
}

}