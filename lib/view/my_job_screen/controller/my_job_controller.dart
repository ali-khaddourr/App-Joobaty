import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/core/service/link.dart';

class MyJobsController extends GetxController{
  bool isLoading = false;

  List dataJobs = [];
  Future<void> fetchData({
    String? search,
    List<String>? jobTitles, // تغيير هنا لقائمة من العناوين
    List<int>? countryIds, // تغيير هنا لقائمة من المعرفات
    List<int>? companyId, // تغيير هنا لقائمة من المعرفات
    List<int>? industryId, // تغيير هنا لقائمة من المعرفات
    List<int>? jobskillId, // تغيير هنا لقائمة من المعرفات
    List<int>? functionalareaId, // تغيير هنا لقائمة من المعرفات
    String? functionalareaName,
    List<int>? stateId, // تغيير هنا لقائمة من المعرفات
    List<int>? cityId, // تغيير هنا لقائمة من المعرفات
    List<int>? isfreelance, // تغيير هنا لقائمة من المعرفات
    List<int>? careerlevelId, // تغيير هنا لقائمة من المعرفات
    List<int>? jobtypeId, // تغيير هنا لقائمة من المعرفات
    List<int>? jobshiftId, // تغيير هنا لقائمة من المعرفات
    List<int>? genderId, // تغيير هنا لقائمة من المعرفات
    List<int>? degreelevelId, // تغيير هنا لقائمة من المعرفات
    List<int>? jobexperienceId, // تغيير هنا لقائمة من المعرفات
    String? salaryfrom,
    String? salaryto,
    int? isfeatured,
  }) async {
    isLoading = true;
    try {
      final uri = Uri.parse('${AppLink.myapplication}').replace(queryParameters: {
        'search': search,
        'job_title[]': jobTitles?.join(','), // انضم إلى القائمة كقيمة مفصولة
        'company_id[]': companyId?.join(','), // انضم إلى القائمة كقيمة مفصولة
        'industry_id[]': industryId?.join(','), // انضم إلى القائمة كقيمة مفصولة
        'job_skill_id[]': jobskillId?.join(','), // انضم إلى القائمة كقيمة مفصولة
        'functional_area_id[]': functionalareaId?.join(','), // انضم إلى القائمة كقيمة مفصولة
        'functional_area_name': functionalareaName,
        'country_id[]': countryIds?.join(','), // انضم إلى القائمة كقيمة مفصولة
        'state_id[]': stateId?.join(','), // انضم إلى القائمة كقيمة مفصولة
        'city_id[]': cityId?.join(','), // انضم إلى القائمة كقيمة مفصولة
        'is_freelance[]': isfreelance?.join(','), // انضم إلى القائمة كقيمة مفصولة
        'career_level_id[]': careerlevelId?.join(','), // انضم إلى القائمة كقيمة مفصولة
        'job_type_id[]': jobtypeId?.join(','), // انضم إلى القائمة كقيمة مفصولة
        'job_shift_id[]': jobshiftId?.join(','), // انضم إلى القائمة كقيمة مفصولة
        'gender_id[]': genderId?.join(','),
        'degree_level_id[]': degreelevelId?.join(','), // انضم إلى القائمة كقيمة مفصولة
        'job_experience_id[]': jobexperienceId?.join(','), // انضم إلى القائمة كقيمة مفصولة
        'salary_from': salaryfrom,
        'salary_to': salaryto,
        'is_featured': isfeatured,
      });
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await http.get(uri, headers: {'Accept': 'application/json','Authorization':'Bearer ${token}'});
      if (response.statusCode == 200) {
        final decodeResponse = json.decode(response.body);
        final dataList = decodeResponse['applied_jobs']['data'] as List<dynamic>;
        dataJobs = dataList.map((jobData) => jobData['job']).toList();
        isLoading = false;
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
@override
  void onInit() {
  fetchData();
    // TODO: implement onInit
    super.onInit();
  }
}