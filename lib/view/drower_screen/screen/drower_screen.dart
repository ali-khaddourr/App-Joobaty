import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/core/const_data/app_colors.dart';
import 'package:test1/core/const_data/my_size.dart';
import 'package:test1/core/service/routes.dart';
import 'package:test1/view/details_company/view/CompaniesScreen.dart';
import 'package:test1/view/details_company/view/company_detail.dart';
import 'package:test1/view/drower_screen/controller/drower_controller.dart';
import 'package:test1/view/drower_screen/screen/WebViewPage.dart';

class DrowerScreen extends StatelessWidget {
  const DrowerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(DrowerController());

    return Drawer(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the drawer
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  title: Text('home'.tr),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                  onTap: () {
                    controller.navigateToPage(Routes.homeScreen);
                  },
                ),
                Divider(height: 1, color: Colors.grey),
                // Add Divider here
                ListTile(
                  title: Text('my_jobs'.tr),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                  onTap: () {
                    if (controller.token != null) {
                      controller.navigateToPage(Routes.myJobScreen);
                    } else {
                      controller.navigateToPage(Routes
                          .loginScreen); // إذا كان التوكن غير موجود، توجه إلى شاشة تسجيل الدخول
                    }
                  },
                ),
                Divider(height: 1, color: Colors.grey),
                // Add Divider here
                ListTile(
                  title: Text('Companies'.tr),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CompanyDetailsPage(),
                      ),
                    );
                  },
                ),
                Divider(height: 1, color: Colors.grey),
                // Add Divider here
                ListTile(
                  title: Text('profile'.tr),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                  onTap: () {
                    if (controller.token != null) {
                      controller.navigateToPage(Routes.profileScreen);
                    } else {
                      controller.navigateToPage(Routes
                          .loginScreen); // إذا كان التوكن غير موجود، توجه إلى شاشة تسجيل الدخول
                    }
                  },
                ),
                Divider(height: 1, color: Colors.grey),
                // Add Divider here
                ListTile(
                  title: Text('favorite_jobs'.tr),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                  onTap: () {
                    controller.navigateToPage(Routes.favoriteScreen);
                  },
                ),
                Divider(height: 1, color: Colors.grey),
                // Add Divider here
                GetBuilder<DrowerController>(
                  builder: (controller) {
                    return ListTile(
                      title: Text(controller.token.value != ''
                          ? 'logout'.tr
                          : 'sign_in'.tr),
                      trailing: Icon(Icons.arrow_forward_ios_outlined),
                      onTap: () {
                        if (controller.token.value != '') {
                          controller.navigateToPage(Routes.logoutScreen);
                        } else {
                          controller.navigateToPage(Routes.loginScreen);
                        }
                      },
                    );
                  },
                ),
                Divider(height: 1, color: Colors.grey),
                GetX<DrowerController>(
                  builder: (controller) {
                    if (controller.token.isNotEmpty) {
                      return ListTile(
                        title: Text('delete_account'.tr),
                        trailing: Icon(Icons.arrow_forward_ios_outlined),
                        onTap: () {
                          Get.defaultDialog(
                            title: 'confirm_account_deletion'.tr,
                            middleText: 'are_u_sure'.tr,
                            confirm: ElevatedButton(
                              onPressed: () async {
                                await controller
                                    .deleteProfile(); // استدعاء دالة حذف الحساب
                                Get.back(); // إغلاق الحوار
                              },
                              child: Text('yes'.tr),
                            ),
                            cancel: ElevatedButton(
                              onPressed: () => Get.back(),
                              child: Text('no'.tr),
                            ),
                          );
                        },
                      );
                    } else {
                      return SizedBox
                          .shrink(); // لا تظهر أي شيء إذا لم يكن مسجلاً للدخول
                    }
                  },
                ),
                Divider(height: 1, color: Colors.grey),
                // Add Divider here// Add Divider here
                ListTile(
                  title: Text('languages'.tr),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                  onTap: () {
                    controller.navigateToPage(Routes.languageScreen);
                  },
                ),
                Divider(height: 1, color: Colors.grey),
              ],
            ),
          ),
          ListTile(
            title: Text('about'.tr),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      WebViewPage(url: 'https://www.jobaaty.com/cms/about-us'),
                ),
              );
            },
          ),

          ListTile(
            title: Text('terms'.tr),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WebViewPage(
                      url: 'https://www.jobaaty.com/cms/terms-of-use'),
                ),
              );
            },
          ),
          ListTile(
            title: Text('contact_page'.tr),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      WebViewPage(url: 'https://www.jobaaty.com/contact-us'),
                ),
              );
            },
          ), // Add spacing if needed
        ],
      ),
    );
  }
}
