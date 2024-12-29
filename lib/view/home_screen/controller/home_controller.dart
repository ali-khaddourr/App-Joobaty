import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1/core/service/link.dart';
import 'package:http/http.dart' as http;
import 'package:test1/model/country.dart';

import '../../../model/city.dart';


class HomeController extends GetxController {
  TextEditingController searchController = TextEditingController();

  RxList<Map<String, dynamic>> searchHistory = <Map<String, dynamic>>[].obs;
  var cities = <Map<String, dynamic>>[].obs;
  var blogs = <Map<String, dynamic>>[].obs; // قائمة المدن كـ Map
// قائمة المدن كـ Map
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCities();
    fetchBlogs();// استدعاء الدالة عند التهيئة
  }
  RxList<int> selectedCountryIds = <int>[].obs;
  RxList<Country> selectedCountries = <Country>[].obs;
  void toggleCountrySelection(Country country) {
    if(selectedCountries.contains(country)){
      selectedCountries.remove(country);
    }
    else {
      selectedCountries = <Country>[].obs;
      selectedCountries.add(country);
    }
    // تحديث معرفات الدول المختارة
    selectedCountryIds.value = selectedCountries.map((country) => country.id).toList();

    // تحديث الواجهة بعد الانتهاء من كل شيء
    update();
  }
  void saveSearch() {
    String searchTerm = searchController.text;
    if (searchTerm.isNotEmpty && !searchHistory.any((search) => search['term'] == searchTerm)) {
      searchHistory.add({
        'term': searchTerm,
        'countryIds': List<int>.from(selectedCountryIds),
      });
      update();
    }
  }

  Future<void> fetchCities() async {
    try {
      final response = await http.get(Uri.parse('${AppLink.jobcities}'));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        cities.value = List<Map<String, dynamic>>.from(jsonResponse);
        print(cities.value);
      } else {
        throw Exception('Failed to load cities');
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false; // تغيير حالة التحميل
    }
  }
  Future<void> fetchBlogs() async {
    try {
      String lang = Get.locale?.languageCode ?? 'en'; // الحصول على اللغة الحالية
      final response = await http.get(Uri.parse('${AppLink.blogs}?lang=$lang'));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final blogsData = jsonResponse['blogs']['data'] as List;

        blogs.value = List<Map<String, dynamic>>.from(blogsData);
        print(blogs.value);
      } else {
        throw Exception('Failed to load blogs');
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}