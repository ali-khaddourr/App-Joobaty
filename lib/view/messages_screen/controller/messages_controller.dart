import 'dart:convert';
import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/view/login_screen/screen/login_screen.dart';

class MessagesController extends GetxController {
  String selectedBox = 'incoming_mail'.tr;
  final List<String> messagesType = ['incoming_mail'.tr];
  List<dynamic> conversations = [];
  Map<String, dynamic> userConversation = {};
  String? userToken;
  Timer? _timer;
  int? userId;
  @override
  void onInit() {
    super.onInit();
    fetchUserToken(); // Fetch user token on initialization
  }

  void startTimer(int userId) {  // تغيير الاسم
    this.userId = userId;
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      fetchUserConversation(this.userId!);
    });
  }

  @override
  void onClose() {
    _timer?.cancel(); // Cancel the timer when the controller is closed
    super.onClose();
  }

  Future<void> fetchUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    userToken = prefs.getString('user_token');
    if (userToken == null) {
      Get.off(() => LoginScreen()); // Redirect to login if necessary
    } else {
      fetchConversations(); // Fetch conversations only if the token is available
    }
  }

  Future<void> fetchConversations() async {
    final prefs = await SharedPreferences.getInstance();
    userToken = prefs.getString('user_token');
    print(userToken);
    if (userToken == null) return;

    final response = await http.get(
      Uri.parse('https://messenger.jobaaty.com/api/conversations?gnavTK=$userToken'),
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      conversations = data['data']['conversations'];
      update();
    } else {
      print('Failed to load conversations');
    }
  }

  Future<void> fetchUserConversation(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    userToken = prefs.getString('user_token');
    if (userToken == null) return;

    final response = await http.get(
      Uri.parse('https://messenger.jobaaty.com/api/users/$userId/conversation?gnavTK=$userToken'),
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      userConversation = data['data'];
      update();
    } else {
      print('Failed to load user conversation');
    }
  }

  Future<void> sendMessage(String userId, String message) async {
    final prefs = await SharedPreferences.getInstance();
    userToken = prefs.getString('user_token');
    if (userToken == null || message.isEmpty) return;

    final response = await http.post(
      Uri.parse('https://messenger.jobaaty.com/api/send-message?gnavTK=$userToken'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'to_id': userId,
        'message': message,
      }),
    );

    if (response.statusCode == 200) {
      print('Message sent successfully');
      fetchUserConversation(int.parse(userId));
    } else {
      print('Failed to send message: ${response.body}');
    }
  }

  Future<void> uploadFileAndSendMessage(int userId) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      final file = result.files.single;
      var uploadResponse = await uploadFile(file);

      if (uploadResponse != null) {
        var responseData = json.decode(uploadResponse.body);
        String attachment = responseData['data'][0]['attachment'];
        await sendMessagewithmedia(userId.toString(), attachment);
      }
    } else {
      print('No file selected or unsupported file type.');
    }
  }

  Future<dynamic> uploadFile(PlatformFile file) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://messenger.jobaaty.com/api/file-upload?gnavTK=$userToken'),
    );

    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        file.path!,
        filename: file.name,
      ),
    );

    var response = await request.send();

    if (response.statusCode == 200) {
      print('File uploaded successfully!');
      var responseData = await http.Response.fromStream(response);
      return responseData;
    } else {
      print('Failed to upload file: ${response.statusCode}');
      return null;
    }
  }

  Future<void> sendMessagewithmedia(String userId, String fileName) async {
    final response = await http.post(
      Uri.parse('https://messenger.jobaaty.com/api/send-message?gnavTK=$userToken'),
      headers: {'Accept': 'application/json', 'Content-Type': 'application/json'},
      body: json.encode({
        'to_id': userId,
        'message_type': '2',
        'message': fileName,
        'file_name': fileName,
      }),
    );

    if (response.statusCode == 200) {
      print('Message sent successfully');
      fetchUserConversation(int.parse(userId));
    } else {
      print('Failed to send message: ${response.body}');
    }
  }

  void updatechange(String value) {
    selectedBox = value;
    update();
  }

  List<DropdownMenuItem<String>> get dropdownMenuItems {
    return messagesType.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }
}
