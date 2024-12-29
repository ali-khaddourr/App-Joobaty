import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/core/service/app_configuration_service.dart';
import 'package:test1/core/service/link.dart';
import 'package:test1/model/career_level.dart';
import 'package:test1/model/country.dart';
import 'package:test1/model/currency.dart';
import 'package:test1/model/functional_area.dart';
import 'package:test1/model/job_experience.dart';
import 'package:test1/view/filter_screen/screen/filter_screen.dart';
import 'package:http/http.dart' as http;
import 'package:test1/view/findjobs_screen/screen/find_jobs_screen.dart';
import 'package:test1/view/findjobs_screen/widgets/ApplyPopupContent.dart';
import 'package:test1/view/login_screen/screen/login_screen.dart';

class FindJobsController extends GetxController {
  RxList<int> selectedCountryIds = <int>[].obs;
  RxList<Country> selectedCountries = <Country>[].obs;
  RxList<int> selectedFunctionalAreaIds = <int>[].obs;
  RxList<FunctionalArea> selectedFunctionalAreas = <FunctionalArea>[].obs;
  RxList<int> selectedJobExperienceIds = <int>[].obs;
  RxList<JobExperience> selectedJobExperiences = <JobExperience>[].obs;
  RxList<int> selectedCareerLevelIds = <int>[].obs;
  RxList<CareerLevel> selectedCareerLevels = <CareerLevel>[].obs;
  var currencies = <Currency>[].obs; // تأكد من أن لديك هذه السطر
  RxList<dynamic> profileCv = <dynamic>[].obs; // استخدام RxList
  bool hasApplied = false;
  bool hasexpired = false;
  var checklogin = null;
  // دالة لتبديل حالة اختيار الدولة
  void toggleCountrySelection(Country country) {
    if (selectedCountries.contains(country)) {
      selectedCountries.remove(country);
    } else {
      selectedCountries.add(country);
    }

    // تحديث معرفات الدول المختارة
    selectedCountryIds.value = selectedCountries.map((country) => country.id).toList();

    // تحديث الواجهة بعد الانتهاء من كل شيء
    update();
  }
  void toggleFunctionalAreaSelection(FunctionalArea functionalarea) {
    if (selectedFunctionalAreas.contains(functionalarea)) {
      selectedFunctionalAreas.remove(functionalarea);
    } else {
      selectedFunctionalAreas.add(functionalarea);
    }

    // تحديث معرفات الدول المختارة
    selectedFunctionalAreaIds.value = selectedFunctionalAreas.map((functionalarea) => functionalarea.id).toList();

    // تحديث الواجهة بعد الانتهاء من كل شيء
    update();
  }
  void toggleJobExperienceSelection(JobExperience jobExperience) {
    if (selectedJobExperiences.contains(jobExperience)) {
      selectedJobExperiences.remove(jobExperience);
    } else {
      selectedJobExperiences.add(jobExperience);
    }

    // تحديث معرفات الدول المختارة
    selectedJobExperienceIds.value = selectedJobExperiences.map((jobExperience) => jobExperience.id).toList();

    // تحديث الواجهة بعد الانتهاء من كل شيء
    update();
  }
  void toggleCareerLevelSelection(CareerLevel careerLevel) {
    if (selectedCareerLevels.contains(careerLevel)) {
      selectedCareerLevels.remove(careerLevel);
    } else {
      selectedCareerLevels.add(careerLevel);
    }

    // تحديث معرفات الدول المختارة
    selectedCareerLevelIds.value = selectedCareerLevels.map((careerLevel) => careerLevel.id).toList();

    // تحديث الواجهة بعد الانتهاء من كل شيء
    update();
  }


  TextEditingController seaechController = TextEditingController();
  Map<String, bool> favoriteStatus = {};
  Future<void> loadFavoriteStatuses() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var job in dataJobs) {
      String slug = job["slug"];
      favoriteStatus[slug] = prefs.getBool(slug) ?? false; // Load saved status
    }
  }



  void toggleFavorite(String slug) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isCurrentlyFavorite = favoriteStatus[slug] ?? false;

    favoriteStatus[slug] = !isCurrentlyFavorite;

    if (favoriteStatus[slug]!) {
      await prefs.setBool(slug, true);
      postFavorite(slug);
    } else {
      await prefs.remove(slug);
      deleteFavorite(slug);
    }
    update();
  }


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
      final uri = Uri.parse('${AppLink.jobSearch}').replace(queryParameters: {
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

      final response = await http.get(uri, headers: {'Accept': 'application/json'});

      if (response.statusCode == 200) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token');
        checklogin = token;
        final decodeResponse = json.decode(response.body);
        final dataList = decodeResponse['jobs']['data'] as List<dynamic>;
        dataJobs = dataList.map((job) => job as Map<String, dynamic>).toList();
        print(dataJobs);

        Get.to(FindJobsScreen());
        isLoading = false;
        update();

      }
    } catch (e) {
      print('Failed to load data: $e');
    }
  }


  clickIconFilter() {
    Get.to(() => FilterScreen());
    update();
  }

  @override
  void onInit() {
    super.onInit();
      loadFavoriteStatuses();
      fetchCv();
      update(); // تأكد من تحديث الواجهة بعد تحميل البيانات.
  }
  Future<void> postFavorite(String slug) async {

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final url = Uri.parse('${AppLink.addFavorite}/${slug}');
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        print('4444444444444444444444444444444${response.statusCode}');

        print('Favorite status updated for $slug');
      }
    } catch (e) {
      print('Failed to post favorite: $e');
    }
  }

  Future<void> deleteFavorite(String jobSlug) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.parse('${AppLink.deleteFavorite}/${jobSlug}');
    final response = await http.delete(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token}'
    });

    if (response.statusCode == 200) {
      print('Job deleted successfully');
    } else {
      print('Failed to delete job: ${response.statusCode}');
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

  bool isLoadingApply = false;
  Future<void> applyNow(String slug) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        Get.off(LoginScreen());
        return;
      }

      // تنفيذ الطلب الأول
      final applyUrl = Uri.parse('${AppLink.applyNow}/$slug');
      final response = await http.post(
        applyUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {},
      );

      if (response.statusCode == 200) {
        print('Application started for $slug');
        if(response.body == "Already applied for this job")
          {
            hasApplied = true;
          }
        // عرض النافذة المنبثقة لاختيار CV والعملة
        showApplyPopup(slug);
      } else {
        Get.snackbar('Error', 'Failed to ِApply Job: ${response.body}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future<Map<String, bool>?> fetchJobStatus(String jobId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await http.get(Uri.parse('${AppLink.getJobStatus}/$jobId'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return {
          'isExpired': data['isExpired'],
          'isApplied': data['isApplied'],
        }; // إرجاع القيم في خريطة
      }
    } catch (e) {
      print('Error fetching job status: $e');
    }
    return null; // إرجاع null في حالة حدوث خطأ
  }
  void showApplyPopup(String slug) {
    Get.defaultDialog(
      title: 'Apply Now',
      content: ApplyPopupContent(slug: slug),
    );
  }
  Future<void> fetchCv() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final userid = prefs.getInt('user_id');

      final response = await http.get(
        Uri.parse('${AppLink.fetchCv}/$userid'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);// تحديث القائمة

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        profileCv.assignAll(List<dynamic>.from(data['profileCv']));
        isLoading = false;
        update(); // لتحديث واجهة المستخدم بعد جلب البيانات
      } else {
        print('${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchCurrencies() async {
    try {
      // جلب العملات
      final service = AppConfigurationService();
      final fetchedCurrencies = await service.getCurrencies();
      currencies.value = fetchedCurrencies; // تأكد من أن لديك `currencies` كمتغير `Rx`
      update(); // لتحديث واجهة المستخدم بعد جلب البيانات
    } catch (e) {
      print('Error: $e');
    }
  }

}
