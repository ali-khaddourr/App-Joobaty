import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1/controllers/app_configuration.dart';
import 'package:test1/model/country.dart';
import 'package:test1/model/functional_area.dart';
import 'package:test1/view/findjobs_screen/controller/find_jobs_controller.dart';
import 'package:test1/view/findjobs_screen/widgets/custom_card.dart';

class ListFillter extends StatelessWidget {
  const ListFillter({super.key});

  @override
  Widget build(BuildContext context) {
    var controllerCon = Get.put(AppConfigurationController());
    var controller = Get.put(FindJobsController());

    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        CustomCard(
            icon: Icons.filter_list,
            func: () {
              Get.find<FindJobsController>().clickIconFilter();
            }),
        Card(
          elevation: 4, // إضافة ظل للكارد
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Obx(
            () {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        controller.selectedCountries.isNotEmpty
                            ? controller.selectedCountries
                                .map((e) => e.name)
                                .join(', ')
                            : 'hint_country'.tr,
                      ),
                      SizedBox(width: 8), // مسافة بين النص والأيقونة
                      IconButton(
                        icon: Icon(Icons.arrow_drop_down),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Select Countries'),
                                content: SizedBox(
                                  width: double.maxFinite,
                                  child: ListView.builder(
                                    itemCount: controllerCon.countries.length,
                                    itemBuilder: (context, index) {
                                      final country =
                                          controllerCon.countries[index];
                                      return CheckboxListTile(
                                        title: Text(country.name ?? 'Unknown'),
                                        value: controller.selectedCountries
                                            .contains(country),
                                        onChanged: (bool? value) {
                                          controller.toggleCountrySelection(country);
                                          controller.fetchData(countryIds: controller.selectedCountryIds);
                                          // تحديث واجهة المستخدم مباشرة
                                          Get.forceAppUpdate(); // هذا سيجعل GetX يجدد الواجهة
                                        },
                                      );
                                    },
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Get.back(), // إغلاق الحوار
                                    child: Text('Done'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Card(
          elevation: 4, // إضافة ظل للكارد
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Obx(
                () {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        controller.selectedFunctionalAreas.isNotEmpty
                            ? controller.selectedFunctionalAreas
                            .map((e) => e.name)
                            .join(', ')
                            : 'functional_area'.tr,
                      ),
                      SizedBox(width: 8), // مسافة بين النص والأيقونة
                      IconButton(
                        icon: Icon(Icons.arrow_drop_down),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Select FunctionalAreas'),
                                content: SizedBox(
                                  width: double.maxFinite,
                                  child: ListView.builder(
                                    itemCount: controllerCon.functionalAreas.length,
                                    itemBuilder: (context, index) {
                                      final functionalareas =
                                      controllerCon.functionalAreas[index];
                                      return CheckboxListTile(
                                        title: Text(functionalareas.name ?? 'Unknown'),
                                        value: controller.selectedFunctionalAreas
                                            .contains(functionalareas),
                                        onChanged: (bool? value) {
                                          controller
                                              .toggleFunctionalAreaSelection(functionalareas);
                                          controller.fetchData(
                                              functionalareaId: controller
                                                  .selectedFunctionalAreaIds);
                                          Get.forceAppUpdate();

                                        },
                                      );
                                    },
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Get.back(), // إغلاق الحوار
                                    child: Text('Done'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Card(
          elevation: 4, // إضافة ظل للكارد
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Obx(
                () {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        controller.selectedJobExperiences.isNotEmpty
                            ? controller.selectedJobExperiences
                            .map((e) => e.name)
                            .join(', ')
                            :'job_experiences'.tr,
                      ),
                      SizedBox(width: 8), // مسافة بين النص والأيقونة
                      IconButton(
                        icon: Icon(Icons.arrow_drop_down),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Select JobExperiences'),
                                content: SizedBox(
                                  width: double.maxFinite,
                                  child: ListView.builder(
                                    itemCount: controllerCon.jobExperiences.length,
                                    itemBuilder: (context, index) {
                                      final jobexperiences =
                                      controllerCon.jobExperiences[index];
                                      return CheckboxListTile(
                                        title: Text(jobexperiences.name ?? 'Unknown'),
                                        value: controller.selectedJobExperiences
                                            .contains(jobexperiences),
                                        onChanged: (bool? value) {
                                          controller
                                              .toggleJobExperienceSelection(jobexperiences);
                                          controller.fetchData(
                                              jobexperienceId: controller
                                                  .selectedJobExperienceIds);
                                          Get.forceAppUpdate();

                                        },
                                      );
                                    },
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Get.back(), // إغلاق الحوار
                                    child: Text('Done'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Card(
          elevation: 4, // إضافة ظل للكارد
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Obx(
                () {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        controller.selectedCareerLevels.isNotEmpty
                            ? controller.selectedCareerLevels
                            .map((e) => e.name)
                            .join(', ')
                            :'career_levels'.tr,
                      ),
                      SizedBox(width: 8), // مسافة بين النص والأيقونة
                      IconButton(
                        icon: Icon(Icons.arrow_drop_down),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Select CareerLevels'),
                                content: SizedBox(
                                  width: double.maxFinite,
                                  child: ListView.builder(
                                    itemCount: controllerCon.careerLevels.length,
                                    itemBuilder: (context, index) {
                                      final careerlevels =
                                      controllerCon.careerLevels[index];
                                      return CheckboxListTile(
                                        title: Text(careerlevels.name ?? 'Unknown'),
                                        value: controller.selectedCareerLevels
                                            .contains(careerlevels),
                                        onChanged: (bool? value) {
                                          controller
                                              .toggleCareerLevelSelection(careerlevels);
                                          controller.fetchData(
                                              careerlevelId: controller
                                                  .selectedCareerLevelIds);
                                          Get.forceAppUpdate();

                                        },
                                      );
                                    },
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Get.back(), // إغلاق الحوار
                                    child: Text('Done'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

      ],
    );
    ;
  }
}
