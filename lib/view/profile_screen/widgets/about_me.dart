import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:test1/controllers/app_configuration.dart';
import 'package:test1/core/const_data/app_colors.dart';
import 'package:test1/core/const_data/my_size.dart';
import 'package:test1/model/career_level.dart';
import 'package:test1/model/country.dart';
import 'package:test1/model/functional_area.dart';
import 'package:test1/model/industry.dart';
import 'package:test1/model/job_experience.dart';
import 'package:test1/model/nationality.dart';
import 'package:test1/view/profile_screen/controller/profile_controller.dart';
import 'package:test1/view/profile_screen/widgets/custom_droup.dart';
import 'package:test1/widgets/text_cutom.dart';
class AboutMee extends StatelessWidget {
  final TextEditingController controllerFirstName;
  final TextEditingController controllerMiddleName;
  final TextEditingController controllerLastName;
  final TextEditingController controllerEmail;
  final PhoneController controllerPhone;
  final TextEditingController controllerPassword;
  final TextEditingController controllerDMY;
  final TextEditingController controllerNationalIdCard ;
  final TextEditingController controllerStatID ;
  final TextEditingController controllerCurrentSalary ;
  final TextEditingController controllerExpectedSalary ;
  final TextEditingController controllerStreetAddress ;


  const AboutMee({
    super.key,
    required this.controllerFirstName,
    required this.controllerLastName,
    required this.controllerMiddleName,
    required this.controllerEmail,
    required this.controllerPhone,
    required this.controllerPassword,
    required this.controllerDMY,
     required this.controllerNationalIdCard, required this.controllerStatID, required this.controllerCurrentSalary, required this.controllerExpectedSalary, required this.controllerStreetAddress,
  });

  @override
  Widget build(BuildContext context) {
    var controllerCon = Get.put(AppConfigurationController());

    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        return controller.isLoading
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 10),
              Text(
                'Loading...',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
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
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controllerFirstName,
                        decoration: InputDecoration(hintText: '${controller.infoProfile['first_name']}'),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: TextFormField(
                        controller: controllerMiddleName,
                        decoration: InputDecoration(hintText: '${controller.infoProfile['last_name']}'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: controllerLastName,
                  decoration: InputDecoration(hintText: '${controller.infoProfile['middle_name']}'),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: controllerEmail,
                  decoration: InputDecoration(hintText: '${controller.infoProfile['email']}'),
                ),
                SizedBox(height: 16.0),
                PhoneFormField(
                  controller: controllerPhone,
                  decoration: InputDecoration(
                    hintText: '${controller.infoProfile['phone']}',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: controllerDMY,
                  decoration: InputDecoration(hintText: '${controller.infoProfile['date_of_birth']}'),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: controllerPassword,
                  decoration: InputDecoration(hintText: 'Password'),
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Obx(() {
                          // احصل على الدولة المختارة (أول دولة من القائمة)
                          Country? selectedCountry = controller
                              .selectedCountries.isNotEmpty
                              ? controller.selectedCountries.first
                              : null;

                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0,left: 8.0),
                            child: DropdownButtonFormField<Country>(
                              value: selectedCountry,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'hint_country'.tr,
                              ),
                              items: controllerCon.countries
                                  .map((country) {
                                return DropdownMenuItem<Country>(
                                  value: country,
                                  child: Text(
                                      country.name ?? 'Unknown'),
                                );
                              }).toList(),
                              onChanged: (Country? newValue) {
                                controller.toggleCountrySelection(
                                    newValue!);
                                print('4444444444444444444444444444444444444444444444444${
                                        controller.selectedCountryIds.first
                                      }444444444444444444444444444444444');
                              },
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Obx(() {
                          // احصل على الدولة المختارة (أول دولة من القائمة)
                          Industry? selectedIndustry = controller
                              .selectedIndustry.isNotEmpty
                              ? controller.selectedIndustry.first
                              : null;

                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0,left: 8.0),
                            child: DropdownButtonFormField<Industry>(
                              value: selectedIndustry,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Industry'.tr,
                              ),
                              items: controllerCon.industries
                                  .map((industry) {
                                return DropdownMenuItem<Industry>(
                                  value: industry,
                                  child: Text(
                                      industry.name ?? 'Unknown'),
                                );
                              }).toList(),
                              onChanged: (Industry? newValue) {
                                controller.toggleIndustrySelection(
                                    newValue!);
                              },
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Obx(() {
                          CareerLevel? selectedCareerLevel = controller
                              .selectedCareerLevels.isNotEmpty
                              ? controller.selectedCareerLevels.first
                              : null;

                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0,left: 8.0),
                            child: DropdownButtonFormField<CareerLevel>(
                              value: selectedCareerLevel,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Career Level'.tr,
                              ),
                              items: controllerCon.careerLevels
                                  .map((careerLevels) {
                                return DropdownMenuItem<CareerLevel>(
                                  value: careerLevels,
                                  child: Text(
                                      careerLevels.name ?? 'Unknown'),
                                );
                              }).toList(),
                              onChanged: (CareerLevel? newValue) {
                                controller.toggleCareerLevelSelection(
                                    newValue!);
                              },
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Obx(() {
                          FunctionalArea? selectedFunctionalArea = controller
                              .selectedFunctionalAreas.isNotEmpty
                              ? controller.selectedFunctionalAreas.first
                              : null;

                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0,left: 8.0),
                            child: DropdownButtonFormField<FunctionalArea>(
                              value: selectedFunctionalArea,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'FunctionalArea'.tr,
                              ),
                              items: controllerCon.functionalAreas
                                  .map((functionalArea) {
                                return DropdownMenuItem<FunctionalArea>(
                                  value: functionalArea,
                                  child: Text(
                                      functionalArea.name ?? 'Unknown'),
                                );
                              }).toList(),
                              onChanged: (FunctionalArea? newValue) {
                                controller.toggleFunctionalAreaSelection(
                                    newValue!);
                              },
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.0),
                Row(
                  children: [
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Obx(() {
                          JobExperience? selectedJobExperience = controller
                              .selectedJobExperiences.isNotEmpty
                              ? controller.selectedJobExperiences.first
                              : null;

                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0,left: 8.0),
                            child: DropdownButtonFormField<JobExperience>(
                              value: selectedJobExperience,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Experience'.tr,
                              ),
                              items: controllerCon.jobExperiences
                                  .map((jobExperiences) {
                                return DropdownMenuItem<JobExperience>(
                                  value: jobExperiences,
                                  child: Text(
                                      jobExperiences.name ?? 'Unknown'),
                                );
                              }).toList(),
                              onChanged: (JobExperience? newValue) {
                                controller.toggleJobExperienceSelection(
                                    newValue!);
                              },
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Obx(() {
                          Nationality? selectedNationality = controller
                              .selectedNationality.isNotEmpty
                              ? controller.selectedNationality.first
                              : null;

                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0,left: 8.0),
                            child: DropdownButtonFormField<Nationality>(
                              value: selectedNationality,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Nationality'.tr,
                              ),
                              items: controllerCon.nationalities
                                  .map((nationality) {
                                return DropdownMenuItem<Nationality>(
                                  value: nationality,
                                  child: Text(
                                      nationality.name ?? 'Unknown'),
                                );
                              }).toList(),
                              onChanged: (Nationality? newValue) {
                                controller.toggleNationalitySelection(
                                    newValue!);
                              },
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: controllerStatID,
                  decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                      hintText: '${controller.infoProfile['stat_id']}',
                  labelText: 'Stat ID'),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: controllerNationalIdCard,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: '${controller.infoProfile['national_id_card_number']}',
                  labelText: 'National Id Card Number'),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: controllerCurrentSalary,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: '${controller.infoProfile['current_salary']}',
                  labelText: 'Current Salary'),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: controllerExpectedSalary,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: '${controller.infoProfile['expected_salary']}',
                  labelText: 'Expected Salary'),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: controllerStreetAddress,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: '${controller.infoProfile['street_address']}',
                  labelText: 'Street Address'),
                ),


                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(MySize.borderRadius),
                    color: AppColors.red9,
                  ),
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.updateProfile();
                    },
                    child: TextCustom(
                      text: 'Save Edit',
                      color: AppColors.white,
                      size: MySize.fontSizeLg,
                      fontW: FontWeight.bold,
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(AppColors.red9),
                    ),
                  ),
                ),
                SizedBox(height: 40),

              ],
            ),
          ),
        );
      },
    );
  }
}
