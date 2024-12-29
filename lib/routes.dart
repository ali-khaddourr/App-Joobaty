import 'package:get/get.dart';
import 'package:test1/view/favorite_screen/screen/favorite_screen.dart';
import 'package:test1/view/home_screen/screen/home_screen.dart';
import 'package:test1/view/language_screen/screen/language_screen.dart';
import 'package:test1/view/login_screen/screen/login_screen.dart';
import 'package:test1/view/logout_screen/screen/logout_screen.dart';
import 'package:test1/view/my_job_screen/view/my_job_screen.dart';
import 'package:test1/view/profile_screen/screen/profile.dart';
import 'package:test1/view/register_screen/screen/register_screen.dart';
import 'package:test1/view/splash_screen/screen/splash_screen.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(name: '/homeScreen', page: () => const HomeScreen()),
  GetPage(name: '/logoutScreen', page: () => const LogoutScreen()),
  GetPage(name: '/loginScreen', page: () => const LoginScreen()),
  GetPage(name: '/registerScreen', page: () => const RegisterScreen()),
  GetPage(name: '/languageScreen', page: () => const LanguageScreen()),
  GetPage(name: '/splashScreen', page: () => const SplashScreen()),
  GetPage(name: '/favoriteScreen', page: () => const FavoriteScreen()),
  GetPage(name: '/profileScreen', page: () => const Profile()),
  GetPage(name: '/myJobScreen', page: () => const MyJobs()),




];
