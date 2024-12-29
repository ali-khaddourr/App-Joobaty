import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/core/const_data/app_colors.dart';
import 'package:test1/core/const_data/my_size.dart';
import 'package:test1/view/findjobs_screen/controller/find_jobs_controller.dart';
import 'package:test1/view/login_screen/screen/login_screen.dart';
import 'package:test1/widgets/text_cutom.dart';
import 'package:flutter_html/flutter_html.dart';


class SingleJob extends StatelessWidget {
  final String? token;

  const SingleJob(this.token, {super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(FindJobsController());
    bool hasApplied = false;
    bool hasExpired= false;

    return
      ListView.builder(
      itemCount: controller.dataJobs.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final job = controller.dataJobs[index] ?? "null";
        final slug = job["slug"];
        final isFavorite = controller.favoriteStatus[slug] ?? false;

        return GestureDetector(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(MySize.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          TextCustom(
                            text: '${controller.dataJobs[index]["title"]}' ??
                                "null",
                            size: MySize.fontSizeLg,
                            fontW: FontWeight.bold,
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () async {
                              if (isFavorite) {
                                await controller.deleteFavorite(slug);
                              } else {
                                await controller.postFavorite(slug);
                              }
                              controller.toggleFavorite(slug);
                              // Save to SharedPreferences
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setBool(slug, !isFavorite);
                            },
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              color: isFavorite ? Colors.red : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      TextCustom(
                        text: '${controller.dataJobs[index]["company_name"]}' ??
                            "null",
                        size: MySize.fontSizeMd,
                      ),
                      SizedBox(height: MySize.sm),
                      TextCustom(
                        text:
                            '${controller.dataJobs[index]["job_type_name"]}' ??
                                "null",
                        size: MySize.fontSizeMd,
                      ),
                      SizedBox(height: MySize.sm),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.money, color: Colors.white),
                            SizedBox(width: 8.0),
                            TextCustom(
                              text:
                                  '\$${controller.dataJobs[index]["salary_from"]} - \$${controller.dataJobs[index]["salary_to"]}' ??
                                      "null",
                              size: MySize.fontSizeMd,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: MySize.sm),
                      Row(
                        children: [
                          Icon(Icons.send, color: Colors.blue[800]),
                          SizedBox(width: MySize.sm),
                          TextCustom(text: 'Apply_with'.tr),
                        ],
                      ),
                      SizedBox(height: MySize.sm),
                      Row(
                        children: [
                          Icon(Icons.person_add, color: Colors.red),
                          SizedBox(width: MySize.sm),
                          TextCustom(text: 'Hiring_multiple'.tr),
                        ],
                      ),
                      SizedBox(height: MySize.sm),
                      Row(
                        children: [
                          Icon(Icons.lock_clock, color: Colors.grey),
                          SizedBox(width: MySize.sm),
                          TextCustom(text: 'Urgently_needed'.tr),
                        ],
                      ),
                      SizedBox(height: MySize.md),
                      // Row(
                      //   children: [
                      //     TextCustom(text: 'Today'),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: MySize.md),
            ],
          ),
          onTap: () async {
            controller.detailsJobData = null; // Reset the job details
            await controller.detailsJob('${job["slug"]}');
            final jobStatus = await controller.fetchJobStatus( job["id"].toString());
            print(job["id"].toString());
            print(jobStatus);
    if (jobStatus != null) {
      hasApplied = jobStatus['isApplied'] ?? false;
      hasExpired = jobStatus['isExpired'] ?? false;
    }
            showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25.0),
                ),
              ),
              isScrollControlled: true,
              builder: (context) {
                return Stack(
                  children: [
                    SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: MySize.xl),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: MySize.md, right: MySize.md, top: MySize.xl),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                              child: Container(
                                width: 30,
                                height: 4,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: MySize.la),
                            TextCustom(
                              text:
                                  "${controller.detailsJobData?["job"]["title"] ?? "null"}",
                              size: MySize.fontSizeXlg,
                              fontW: FontWeight.bold,
                            ),
                            SizedBox(height: MySize.sm),
                            TextCustom(
                                text:
                                    "${controller.detailsJobData?["country_name"] ?? "null"}/${controller.detailsJobData?["state_name"] ?? "null"}/${controller.detailsJobData?["city_name"] ?? "null"}"),
                            SizedBox(height: MySize.sm),

                            SizedBox(height: MySize.la),
                            TextCustom(
                              text: 'Job_details'.tr,
                              size: MySize.fontSizeXlg,
                              fontW: FontWeight.bold,
                            ),
                            SizedBox(height: MySize.md),
                            TextCustom(
                              text: 'salary'.tr,
                              size: MySize.fontSizeLg,
                              fontW: FontWeight.bold,
                            ),
                            SizedBox(height: MySize.sm),
                            TextCustom(
                              text:
                                  '\$${controller.dataJobs[index]["salary_from"]} - \$${controller.dataJobs[index]["salary_to"]}' ??
                                      "null",
                            ),
                            SizedBox(height: MySize.md),
                            TextCustom(
                              text: 'Job_type'.tr,
                              size: MySize.fontSizeLg,
                              fontW: FontWeight.bold,
                            ),
                            SizedBox(height: MySize.sm),
                            TextCustom(
                              text:
                                  "${controller.dataJobs[index]["job_type_name"]}" ??
                                      "null",
                            ),
                            SizedBox(height: MySize.md),
                            TextCustom(
                              text: 'Number_of'.tr,
                              size: MySize.fontSizeLg,
                              fontW: FontWeight.bold,
                            ),
                            SizedBox(height: MySize.md),
                            TextCustom(
                              text: '3',
                            ),
                            SizedBox(height: MySize.sm),
                            Container(
                              width: double.infinity,
                              height: 1,
                              color: Colors.black,
                            ),
                            SizedBox(height: MySize.la),
                            TextCustom(
                              text: 'Full_Job'.tr,
                              size: MySize.fontSizeXlg,
                              fontW: FontWeight.bold,
                            ),
                            SizedBox(height: MySize.md),
                            TextCustom(
                              text: 'description'.tr,
                              fontW: FontWeight.bold,
                            ),
                            SizedBox(height: MySize.md),
                            Row(
                              children: [
                                Icon(Icons.circle, size: 10),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Html(
                                    data: controller.detailsJobData?["job"]["description"] ?? "No description available.",
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: MySize.md),
                            TextCustom(
                              text: 'benefits'.tr,
                              fontW: FontWeight.bold,
                            ),
                            Row(
                              children: [
                                Icon(Icons.circle, size: 10),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Html(
                                   data: '${controller.detailsJobData?["job"]["benefits"] ?? "null"}',
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: MySize.xl),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: MySize.md),
                        child: ElevatedButton(
                          onPressed: () {
                            if (token != null && token!.isNotEmpty) {
                              if (!hasExpired) {
                                if (!hasApplied) {
                                  controller.applyNow('${job["slug"]}');
                                } else {
                                  // أظهر رسالة "تم التقديم بالفعل"
                                }
                              } else {
                                // أظهر رسالة "الوظيفة منتهية"
                              }
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginScreen()),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: (hasExpired || hasApplied) ? Colors.grey : Colors.red[700],
                            elevation: 5,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Text(
                            token != null && token!.isNotEmpty
                                ? (hasExpired ? 'Job_Expired'.tr : (hasApplied ? 'Already_Applied'.tr : 'Apply_Now'.tr))
                                : 'log_in'.tr,
                            style: TextStyle(color: AppColors.white, fontSize: MySize.fontSizeLg),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
