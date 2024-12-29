import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1/binding/initial_bindings.dart';
import 'package:test1/core/service/my_service.dart';
import 'package:test1/core/service/routes.dart';
import 'package:test1/lang/translations.dart';
import 'package:test1/routes.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:test1/view/details_company/view/CompaniesScreen.dart';
import 'package:test1/view/findjobs_screen/screen/find_jobs_screen.dart';
import 'package:test1/view/home_screen/screen/home_screen.dart';
import 'package:test1/view/infomedia_profile_sceen/screen/infomedia_profile_screen.dart';

import 'package:test1/view/login_screen/screen/login_screen.dart';
import 'package:test1/view/my_job_screen/view/my_job_screen.dart';
import 'package:test1/view/profile_screen/screen/profile.dart';
import 'package:test1/view/splash_screen/screen/splash_screen.dart';
import 'firebase_options.dart';

import 'view/messages_screen/screen/message_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MyService();
  await initialServices();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      themeMode: ThemeMode.system,
      translations: Translation(),
      locale: Locale('en'),
      fallbackLocale: Locale('en'),
      initialBinding: initialBindings(),
      getPages: routes,
      // initialRoute: Routes.loginScreen,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
