import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:get/get.dart';
import 'package:test1/core/service/link.dart';
import 'package:test1/view/details_company/controller/details_company_controller.dart';
import 'package:test1/view/findjobs_screen/controller/find_jobs_controller.dart';
import 'jobs_bar.dart';
import 'profile_bar.dart';

class CompanyDetail extends StatelessWidget {
  const CompanyDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final DetailsCompanyController controller = Get.find();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(actions: []),
        body: Column(
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                width: MediaQuery.of(context).size.width / 1.5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Column(
                    children: [
                      Column( // استخدم Column بدلاً من Row
                        children: [
                          Image.network(
                            '${AppLink.appRoot}/company_logos/${controller.companyDetails['logo']}',
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.width * 0.37,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.error); // عرض أيقونة خطأ في حالة فشل تحميل الصورة
                            },
                          ),
                          SizedBox(height: 10), // مساحة بين الصورة والاسم
                          Text(
                            controller.companyDetails['name'] ?? 'N/A',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center, // محاذاة العناصر في منتصف الصف
                            children: [
                              Text('5.0', style: TextStyle(color: Colors.red)),
                              SizedBox(width: 5),
                              Icon(Icons.star, size: 15, color: Colors.red),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: ContainedTabBarView(
                  tabBarProperties: TabBarProperties(
                    labelPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    isScrollable: true,
                    labelStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.w500, fontSize: 15),
                    padding: EdgeInsets.all(8),
                    unselectedLabelStyle: TextStyle(fontSize: 15, color: Colors.black87),
                    indicatorColor: Colors.red,
                  ),
                  tabs: [
                    Text('profile'.tr),
                    Text('jobs'.tr),
                  ],
                  views: [
                    ProfileBar(companyData: controller.companyDetails), // تمرير بيانات الشركة هنا
                    JobsBar(companyId: controller.companyDetails['id']),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

