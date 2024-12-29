import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void onInit() {
    super.onInit();
    _initializeFCM();
  }

  void _initializeFCM() async {
    await _firebaseMessaging.requestPermission();

    String? myToken = await _firebaseMessaging.getToken();
    print('Firebase Messaging Token: $myToken');

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a message while in foreground: ${message.messageId}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked! ${message.messageId}');
    });
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    print('Handling a background message: ${message.messageId}');
  }
}
