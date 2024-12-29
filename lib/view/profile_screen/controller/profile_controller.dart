import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/controllers/app_configuration.dart';
import 'package:test1/core/const_data/app_image.dart';
import 'package:test1/core/const_data/my_size.dart';
import 'package:test1/core/service/link.dart';
import 'package:http/http.dart' as http;
import 'package:test1/model/career_level.dart';
import 'package:test1/model/country.dart';
import 'package:test1/model/functional_area.dart';
import 'package:test1/model/industry.dart';
import 'package:test1/model/job_experience.dart';
import 'package:test1/model/my_profile_model.dart';
import 'package:test1/model/nationality.dart';
import 'package:test1/widgets/text_cutom.dart';
import 'package:video_player/video_player.dart';

class ProfileController extends GetxController {
  var first_name;
  List<dynamic> profileCv = [];
  var infoProfile;
  final TextEditingController summaryController = TextEditingController();


  bool isLoading = false;

  Future<void> fetchData() async {
    isLoading = true;

    try {
      final url =
          Uri.parse('${AppLink.MyProfile}');
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await http.get(url, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}',
      });

      if (response.statusCode == 200) {
        print(
            '++++++++++++++++++++++++++++++++++++++++++++${response.statusCode}+++++++++++++++++++++++++++++++++++++++++++');

        var decodeResponse = json.decode(response.body);
        infoProfile = decodeResponse['user'];
        summaryController.text = decodeResponse['summary']['summary'];
        isLoading = false;
        update();
        print(
            '++++++++++++++++++++++++++++++++++++++++++++${infoProfile['id']}+++++++++++++++++++++++++++++++++++++++++++');
      }
    } catch (e) {
      // Handle errors
      print('Error: $e');
    }
  }

  var countries;

  RxList<int> selectedCountryIds = <int>[].obs;
  RxList<Country> selectedCountries = <Country>[].obs;
  RxList<int> selectedIndustryIds = <int>[].obs;
  RxList<Industry> selectedIndustry = <Industry>[].obs;
  RxList<int> selectedFunctionalAreaIds = <int>[].obs;
  RxList<FunctionalArea> selectedFunctionalAreas = <FunctionalArea>[].obs;
  RxList<int> selectedJobExperienceIds = <int>[].obs;
  RxList<JobExperience> selectedJobExperiences = <JobExperience>[].obs;
  RxList<int> selectedCareerLevelIds = <int>[].obs;
  RxList<CareerLevel> selectedCareerLevels = <CareerLevel>[].obs;
  RxList<int> selectedNationalityIds = <int>[].obs;
  RxList<Nationality> selectedNationality = <Nationality>[].obs;

  void toggleNationalitySelection(Nationality nationality) {
    if (selectedNationality.contains(nationality)) {
      selectedNationality.remove(nationality);
    } else {
      selectedNationality = <Nationality>[].obs;
      selectedNationality.add(nationality);
    }
    // تحديث معرفات الدول المختارة
    selectedNationalityIds.value =
        selectedNationality.map((nationality) => nationality.id).toList();

    // تحديث الواجهة بعد الانتهاء من كل شيء
    update();
  }

  void toggleCountrySelection(Country country) {
    if (selectedCountries.contains(country)) {
      selectedCountries.remove(country);
    } else {
      selectedCountries = <Country>[].obs;
      selectedCountries.add(country);
    }
    // تحديث معرفات الدول المختارة
    selectedCountryIds.value =
        selectedCountries.map((country) => country.id).toList();

    // تحديث الواجهة بعد الانتهاء من كل شيء
    update();
  }

  void toggleFunctionalAreaSelection(FunctionalArea functionalArea) {
    if (selectedFunctionalAreas.contains(functionalArea)) {
      selectedFunctionalAreas.remove(functionalArea);
    } else {
      selectedFunctionalAreas = <FunctionalArea>[].obs;
      selectedFunctionalAreas.add(functionalArea);
    }
    selectedFunctionalAreaIds.value = selectedFunctionalAreas
        .map((functionalArea) => functionalArea.id)
        .toList();

    // تحديث الواجهة بعد الانتهاء من كل شيء
    update();
  }

  void toggleJobExperienceSelection(JobExperience jobExperience) {
    if (selectedJobExperiences.contains(jobExperience)) {
      selectedJobExperiences.remove(jobExperience);
    } else {
      selectedJobExperiences = <JobExperience>[].obs;
      selectedJobExperiences.add(jobExperience);
    }
    selectedJobExperienceIds.value = selectedJobExperiences
        .map((jobExperience) => jobExperience.id)
        .toList();

    // تحديث الواجهة بعد الانتهاء من كل شيء
    update();
  }

  void toggleCareerLevelSelection(CareerLevel careerLevel) {
    if (selectedCareerLevels.contains(careerLevel)) {
      selectedCareerLevels.remove(careerLevel);
    } else {
      selectedCareerLevels = <CareerLevel>[].obs;
      selectedCareerLevels.add(careerLevel);
    }
    selectedCareerLevelIds.value =
        selectedCountries.map((careerLevel) => careerLevel.id).toList();

    // تحديث الواجهة بعد الانتهاء من كل شيء
    update();
  }

  void toggleIndustrySelection(Industry industry) {
    if (selectedIndustry.contains(industry)) {
      selectedIndustry.remove(industry);
    } else {
      selectedIndustry = <Industry>[].obs;
      selectedIndustry.add(industry);
    }
    selectedIndustryIds.value =
        selectedIndustry.map((industry) => industry.id).toList();

    // تحديث الواجهة بعد الانتهاء من كل شيء
    update();
  }

  @override
  void onInit() async {
    await fetchData();
    await fetchCv();
    // TODO: implement onInit
    super.onInit();
  }

  TextEditingController controllerFirstN = TextEditingController();
  TextEditingController controllerMiddleN = TextEditingController();
  TextEditingController controllerLastN = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  PhoneController controllerPhone = PhoneController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerDMY = TextEditingController();
  TextEditingController controllerSalary = TextEditingController();
  TextEditingController controllerNationalIdCard = TextEditingController();
  TextEditingController controllerStatID = TextEditingController();
  TextEditingController controllerCurrentSalary = TextEditingController();
  TextEditingController controllerExpectedSalary = TextEditingController();
  TextEditingController controllerStreetAddress = TextEditingController();

  var profileImage = Rxn<File>();
  var coverImage = Rxn<File>();

  void showImageOptions(BuildContext context) {
    final ImagePicker _imagePicker = ImagePicker();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          width: double.infinity,
          height: 220,
          child: Padding(
            padding: const EdgeInsets.all(MySize.la),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 50,
                    height: 4,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: MySize.la),
                // عرض الصورة الشخصية
                GestureDetector(
                  onTap: () {
                    // عرض الصورة كاملة
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              'https://www.jobaaty.com/public/user_images/${infoProfile['image']}' ,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        child: Icon(Icons.visibility, color: Colors.black),
                      ),
                      SizedBox(width: 10),
                      TextCustom(
                          text: 'Show Profile Picture',
                          size: MySize.fontSizeLg),
                    ],
                  ),
                ),
                SizedBox(height: MySize.sm),
                // تعديل الصورة الشخصية
                GestureDetector(
                  onTap: () async {
                    final pickedFile = await _imagePicker.pickImage(
                        source: ImageSource.gallery);
                    if (pickedFile != null) {
                      profileImage.value = File(pickedFile.path);
                      updateProfileMedia();
                      fetchData();
                    }

                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        child: Icon(Icons.edit, color: Colors.black),
                      ),
                      SizedBox(width: 10),
                      TextCustom(
                          text: "Edit Profile Picture",
                          size: MySize.fontSizeLg),
                    ],
                  ),
                ),
                SizedBox(height: MySize.sm),
                // تعديل صورة الغلاف
                GestureDetector(
                  onTap: () async {
                    final pickedFile = await _imagePicker.pickImage(
                        source: ImageSource.gallery);
                    print('Picked file path: ${pickedFile!.path}');
                    if (pickedFile != null) {
                      coverImage.value = File(pickedFile.path);
                      updateProfileMedia();
                      fetchData();
                    }
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        child: Icon(Icons.image, color: Colors.black),
                      ),
                      SizedBox(width: 10),
                      TextCustom(
                          text: "Edit Cover Image", size: MySize.fontSizeLg),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> updateProfile() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final url = Uri.parse('${AppLink.updateProfile}');
       var request = http.MultipartRequest('POST', url)
          ..headers['Accept'] = 'application/json'
          ..headers['Authorization'] = 'Bearer $token';


        // إضافة الحقول الأخرى
        request.fields['first_name'] =
            controllerFirstN.text; // قم بتغيير القيمة إلى ما تحتاجه
        request.fields['last_name'] = controllerLastN.text;
        request.fields['middle_name'] = controllerMiddleN.text;
        request.fields['email'] = controllerEmail.text;
        request.fields['password'] = controllerPassword.text;
        request.fields['phone'] = controllerPhone.value.toString();
        request.fields['country_id'] =
            selectedCountryIds.value.first.toString();
        request.fields['job_experience_id'] =
            selectedJobExperienceIds.value.first.toString();
        request.fields['career_level_id'] =
            selectedCareerLevelIds.value.toString();
        request.fields['industry_id'] =
            selectedIndustryIds.value.first.toString();
        request.fields['functional_area_id'] =
            selectedFunctionalAreaIds.value.first.toString();
        request.fields['nationality_id'] =
            selectedNationalityIds.value.first.toString();
        request.fields['national_id_card_number'] =
            controllerNationalIdCard.text;
        request.fields['state_id'] = controllerStatID.text;
        request.fields['current_salary'] = controllerCurrentSalary.text;
        request.fields['expected_salary'] = controllerExpectedSalary.text;
        request.fields['street_address'] = controllerStreetAddress.text;

        // إرسال الطلب
        final response = await request.send();

        if (response.statusCode == 200) {
          print('Profile updated successfully');
          Get.snackbar(
            'Success',
            'Profile updated successfully!',
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 3),
          );
          fetchData();
          update();
      }
    } catch (e) {
      print('Failed to post profile: $e');
    }
  }

  Future<void> updateProfileMedia() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final url = Uri.parse('${AppLink.updateProfileMedia}');

      var request = http.MultipartRequest('POST', url)
        ..headers['Accept'] = 'application/json'
        ..headers['Authorization'] = 'Bearer $token';

      // Add profile image if available
      if (profileImage.value != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'image',
          profileImage.value!.path,
        ));
      }

      // Add cover image if available
      if (coverImage.value != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'cover_image',
          coverImage.value!.path,
        ));
      }

      // Send the request
      final response = await request.send();

      if (response.statusCode == 200) {
        print('Profile updated successfully');
        Get.snackbar(
          'Success',
          'Profile updated successfully!',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
        );
        fetchData();
        update();
      } else {
        print('Failed to update profile: ${response.reasonPhrase}');
        Get.snackbar(
          'Error',
          'Failed to update profile: ${response.reasonPhrase}',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
        );
      }
    } catch (e) {
      print('Failed to post profile: $e');
      Get.snackbar(
        'Error',
        'Failed to post profile: $e',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
    }
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

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        profileCv = data['profileCv'];
        isLoading = false;
        update(); // لتحديث واجهة المستخدم بعد جلب البيانات
      } else {
        print('${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> deleteCv(int cvId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      // استخدم Uri.parse لرابط API
      final uri = Uri.parse('${AppLink.deleteCv}');

      // إرسال الطلب مع body يحتوي على cvId
      final response = await http.delete(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({'id': cvId}),
      );

      if (response.statusCode == 200) {
        // حذف السيرة الذاتية من القائمة بعد الحذف بنجاح
        profileCv.removeWhere((cv) => cv['id'] == cvId);
        update(); // تحديث واجهة المستخدم بعد الحذف
        print('CV deleted successfully');
      } else {
        print('${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> uploadCv({
    required String title,
    required bool isDefault,
    File? cvFile,
  }) async {
    try {
      // احصل على التوكن من SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final userid = prefs.getInt('user_id');


      // إعداد الطلب
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${AppLink.addcv}/$userid'),
      );

      // إضافة الهيدر
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      // إضافة الحقول النصية
      request.fields['title'] = title;
      request.fields['is_default'] = isDefault ? '1' : '0';

      // إضافة ملف السيرة الذاتية إذا تم اختياره
      if (cvFile != null) {
        request.files.add(await http.MultipartFile.fromPath('cv_file', cvFile.path));
      }

      // إرسال الطلب
      final response = await request.send();

      // التحقق من نجاح الطلب
      if (response.statusCode == 200) {
        print('CV uploaded successfully');
        fetchCv();
      } else {
        print('Failed to upload CV');
      }
    } catch (e) {
      print('Error uploading CV: $e');
    }
  }

  Future<void> updatesummry() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final userid = prefs.getInt('user_id');


      // استخدم Uri.parse لرابط API
      final uri = Uri.parse('${AppLink.updatesummry}/${userid}');
      String summary = summaryController.text;

      // إرسال الطلب مع body يحتوي على cvId
      final response = await http.post(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({'summary': summary}),
      );

      if (response.statusCode == 200) {
        fetchData();
        update(); // تحديث واجهة المستخدم بعد الحذف
        print('Update Summary successfully');
      } else {
        print('${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}

