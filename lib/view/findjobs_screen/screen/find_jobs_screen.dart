import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1/controllers/app_configuration.dart';

import 'package:test1/core/const_data/my_size.dart';

import 'package:test1/view/findjobs_screen/controller/find_jobs_controller.dart';
import 'package:test1/view/findjobs_screen/widgets/list_fillter.dart';
import 'package:test1/view/findjobs_screen/widgets/single_job.dart';
import 'package:test1/view/home_screen/screen/home_screen.dart';

class FindJobsScreen extends StatelessWidget {
  const FindJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final controllerConfig = Get.put(ConfigurationController());
    // final controllerFind = Get.put(FindJobsController());
    var controllerCon = Get.put(AppConfigurationController());
    var token = null;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Get.off(HomeScreen());
              },
              icon: Icon(Icons.home)),
        ],
      ),
      body: GetBuilder<FindJobsController>(
        init: FindJobsController(),
        builder: (controller) {
          token = controller.checklogin;
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
              : Padding(
                  padding: const EdgeInsets.all(MySize.md),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: controller.seaechController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        MySize.borderRadius),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  hintText: 'hint_search'.tr,
                                  prefixIcon: Icon(Icons.search),
                                ),
                                onTap: () {
                                  controller.fetchData(search: controller.seaechController.text);
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: MySize.md),
                        SizedBox(
                          height: 60,
                          child: ListFillter(),
                        ),
                        SizedBox(height: MySize.md),
                        SingleJob(token),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
