import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/core/service/link.dart';

class FavoriteController extends GetxController {
  List dataJobs = [];

  Future<void> fetchData() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = "19|vaIEj6mliGhBV6I1b3Km5F523rpygLy7RAhdNP3ua52946a3";

      final url = Uri.parse('${AppLink.myFavorite}');
      final response = await http.get(url, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}',

      });

      if (response.statusCode == 200) {
        final decodeResponse = json.decode(response.body);
        final dataList = decodeResponse['jobs']['data'] as List<dynamic>;

         dataJobs = dataList.map((job) => job as Map<String, dynamic>).toList();


        update();
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Failed to load data: $e');
    }
  }

  @override
  void onInit() {
    fetchData();
    // TODO: implement onInit
    super.onInit();
  }
}
