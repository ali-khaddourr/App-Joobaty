import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/core/service/link.dart';

class InfomediaProfileController extends GetxController {
  var profileImage = Rxn<File>();
  var coverImage = Rxn<File>();
  var videoFile = Rxn<File>();

  var uploadProgress = 0.0.obs;
  var isUploading = false.obs;

  final ImagePicker _imagePicker = ImagePicker();

  Future<void> pickProfileImage() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage.value = File(pickedFile.path);
    }
  }

  Future<void> pickCoverImage() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage.value = File(pickedFile.path);
    }
  }

  Future<void> pickVideo() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result != null && result.files.isNotEmpty) {
      videoFile.value = File(result.files.single.path!);
      updateProfileMedia();
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
      if (videoFile.value != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'bio_video',
          videoFile.value!.path,
        ));
      }

      // Send the request
      final response = await request.send();

      if (response.statusCode == 200) {
        print('video updated successfully');
        Get.snackbar(
          'Success',
          'video updated successfully!',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
        );
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


}
