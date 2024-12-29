import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1/core/const_data/my_size.dart';
import 'package:test1/view/my_job_screen/controller/my_job_controller.dart';
import 'package:test1/widgets/text_cutom.dart';

class MyJobs extends StatelessWidget {
  const MyJobs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Jobs'),
      ),
      body: GetBuilder(
        init: MyJobsController(),
        builder: (controller){
          return controller.isLoading
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 10), // مسافة بين الدائرة والنص
                Text(
                  'Loading'.tr,
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5), // مسافة بين النص والثلاث نقاط
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('.'),
                    SizedBox(width: 5),
                    Text('.'),
                    SizedBox(width: 5),
                    Text('.'),
                  ],
                ),
              ],
            ),
          )
              : SingleChildScrollView(
                child: ListView.builder(
                            itemCount: controller.dataJobs.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                final job = controller.dataJobs[index] ?? "null";
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
                                '${controller.dataJobs[index]["job_type"]}' ??
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
                                    // Container(
                                    //   decoration: BoxDecoration(
                                    //     color: Colors.amberAccent[100],
                                    //     borderRadius: BorderRadius.circular(15),
                                    //   ),
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.all(MySize.sm),
                                    //     child: TextCustom(
                                    //       text: 'Urgently needed',
                                    //     ),
                                    //   ),
                                    // ),
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
                                      "${controller.dataJobs[index]["job_type"]}" ??
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
                                    ),
                                    SizedBox(height: MySize.md),
                                    Row(
                                      children: [
                                        Icon(Icons.circle, size: 10),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            '${controller.detailsJobData?["job"]["description"] ?? "null"}',
                                            softWrap: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: MySize.md),
                                    TextCustom(
                                      text: 'benefits'.tr,
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.circle, size: 10),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            '${controller.detailsJobData?["job"]["benefits"] ?? "null"}',
                                            softWrap: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: MySize.xl),
                                  ],
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
                          ),
              );

        },
      ),
    );
  }
}
