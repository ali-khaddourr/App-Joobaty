import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:test1/core/const_data/app_colors.dart';
import 'package:test1/core/const_data/my_size.dart';
import 'package:test1/view/filter_screen/controller/filter_controller.dart';
import 'package:test1/view/findjobs_screen/controller/find_jobs_controller.dart';
import 'package:test1/widgets/text_cutom.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controllerFind = Get.put(FindJobsController());

    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: TextCustom(
          text: 'filters'.tr,
          fontW: FontWeight.bold,
        )),
      ),
      body: GetBuilder(
          init: FilterController(),
          builder: (controller) {
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
                : Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(MySize.la),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextCustom(
                                  text: 'gender'.tr,
                                  fontW: FontWeight.bold,
                                  size: MySize.fontSizeLg,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(MySize.md),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Obx(() {
                                        return Row(
                                          children: [
                                            Checkbox(
                                              value: controller
                                                  .selectedGenderIds
                                                  .contains(
                                                      controller.genders[0].id),
                                              onChanged: (value) {
                                                controller
                                                    .toggleGrnderSelection(
                                                        controller.genders[0]);
                                              },
                                            ),
                                            Text(
                                                '${controller.genders[0].name}'),
                                          ],
                                        );
                                      }),
                                      Obx(() {
                                        return Row(
                                          children: [
                                            Checkbox(
                                              value: controller
                                                  .selectedGenderIds
                                                  .contains(
                                                      controller.genders[1].id),
                                              onChanged: (value) {
                                                controller
                                                    .toggleGrnderSelection(
                                                        controller.genders[1]);
                                              },
                                            ),
                                            Text(
                                                '${controller.genders[1].name}'),
                                          ],
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  height: MySize.la,
                                ),
                                TextCustom(
                                  text: 'salary'.tr,
                                  fontW: FontWeight.bold,
                                  size: MySize.fontSizeLg,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(MySize.md),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              controller: controller.fromSalary,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                ),
                                                label: Text('from'.tr),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MySize.md,
                                          ),
                                          Expanded(
                                            child: TextField(
                                              controller: controller.toSalary,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                ),
                                                label: Text('to'.tr),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(MySize.md),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(MySize.borderRadius),
                            color: AppColors.red9,
                          ),
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              controllerFind.fetchData(
                                salaryfrom: controller.fromSalary.text,
                                salaryto: controller.toSalary.text,
                                genderId: controller.selectedGenderIds,
                              );
                            },
                            child: TextCustom(
                              text: 'update'.tr,
                              color: AppColors.white,
                              size: MySize.fontSizeLg,
                              fontW: FontWeight.bold,
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppColors.red9),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
          }),
    );
  }
}
