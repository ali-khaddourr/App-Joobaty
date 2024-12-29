import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:test1/core/const_data/app_colors.dart';
import 'package:test1/core/const_data/app_image.dart';
import 'package:test1/core/const_data/my_size.dart';
import 'package:test1/view/home_screen/screen/home_screen.dart';
import 'package:test1/view/login_screen/screen/login_screen.dart';
import 'package:test1/view/register_screen/controller/register_controller.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text('sign_up'.tr,
            style:
                TextStyle(color: AppColors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0, // Remove shadow
        actions: [
          IconButton(
            icon: Icon(
              Icons.home,
              color: AppColors.black,
            ),
            onPressed: () {
              Get.to(HomeScreen());
            },
          ),
        ],
      ),
      body: GetBuilder(
        init: RegisterController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.grey[200],
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: MySize.sm, bottom: MySize.sm),
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.asset(
                            AppImage.LogoImage,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(MySize.md),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'v_ready'.tr,
                          style: TextStyle(fontSize: MySize.fontSizeLg),
                        ),
                        SizedBox(
                          height: MySize.sm,
                        ),
                        Text(
                          'v_create'.tr,
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: MySize.sm,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Text('first_name'.tr,
                                    style: TextStyle(
                                        fontSize: MySize.fontSizeLg,
                                        fontWeight: FontWeight.bold))),
                            Expanded(
                                child: Text('last_name'.tr,
                                    style: TextStyle(
                                        fontSize: MySize.fontSizeLg,
                                        fontWeight: FontWeight.bold))),
                          ],
                        ),
                        SizedBox(
                          height: MySize.sm,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controller.firstNameController,
                                decoration: InputDecoration(
                                  hintText: 'hint_first_name'.tr,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        MySize.borderRadius),
                                    borderSide:
                                        BorderSide(color: AppColors.red9),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        MySize.borderRadius),
                                    borderSide: BorderSide(
                                        color: AppColors.red9, width: 2.0),
                                  ),
                                ),
                                validator: (value) {
                                  return controller.nameValidator(value!);
                                },
                              ),
                            ),
                            SizedBox(width: MySize.md),
                            Expanded(
                              child: TextFormField(
                                controller: controller.lastNameController,
                                decoration: InputDecoration(
                                  hintText: 'hint_last_name'.tr,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        MySize.borderRadius),
                                    borderSide:
                                        BorderSide(color: AppColors.red9),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        MySize.borderRadius),
                                    borderSide: BorderSide(
                                        color: AppColors.red9, width: 2.0),
                                  ),
                                ),
                                validator: (value) {
                                  return controller.nameValidator(value!);
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MySize.sm,
                        ),
                        Text(
                          'middle_name'.tr,
                          style: TextStyle(
                              fontSize: MySize.fontSizeLg,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: MySize.sm,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controller.middelNameController,
                                decoration: InputDecoration(
                                  hintText: 'hint_middle_name'.tr,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        MySize.borderRadius),
                                    borderSide:
                                    BorderSide(color: AppColors.red9),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        MySize.borderRadius),
                                    borderSide: BorderSide(
                                        color: AppColors.red9, width: 2.0),
                                  ),
                                ),
                                validator: (value) {
                                  return controller.nameValidator(value!);
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MySize.sm,
                        ),
                        Text(
                          'email'.tr,
                          style: TextStyle(
                              fontSize: MySize.fontSizeLg,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: MySize.sm,
                        ),
                        TextFormField(
                          controller: controller.emailController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            hintText: 'hint_email_name'.tr,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(MySize.borderRadius),
                              borderSide: BorderSide(color: AppColors.red9),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(MySize.borderRadius),
                              borderSide:
                                  BorderSide(color: AppColors.red9, width: 2.0),
                            ),
                          ),
                          validator: (value) {
                            return controller.emailValidator(value!);
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: MySize.sm,
                        ),
                        Text(
                          'phone'.tr,
                          style: TextStyle(
                              fontSize: MySize.fontSizeLg,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: MySize.sm,
                        ),
                        PhoneFormField(
                          controller: controller.phoneController,
                          decoration: InputDecoration(
                            labelText: 'hint_phone'.tr,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(MySize.borderRadius),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MySize.sm,
                        ),
                        Text(
                          'password'.tr,
                          style: TextStyle(
                              fontSize: MySize.fontSizeLg,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: MySize.sm,
                        ),
                        TextFormField(
                          controller: controller.passwordController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.password),
                            hintText: 'hint_password'.tr,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(MySize.borderRadius),
                              borderSide: BorderSide(color: AppColors.red9),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(MySize.borderRadius),
                              borderSide:
                                  BorderSide(color: AppColors.red9, width: 2.0),
                            ),
                          ),
                          validator: (value) {
                            return controller.passwordValidator(value!);
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: MySize.sm,
                        ),
                        Obx(
                          () => TextFormField(
                            controller: controller.confirmPasswordController,
                            decoration: InputDecoration(
                              hintText: 'hint_config_password'.tr,
                              prefixIcon: Icon(
                                Icons.lock,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.isPasswordVisible.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: controller.togglePasswordVisibility,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red[700]!),
                                borderRadius:
                                    BorderRadius.circular(MySize.borderRadius),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red[900]!),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            obscureText: !controller.isPasswordVisible.value,
                            validator: (value) {
                              return controller
                                  .confirmPasswordValidator(value!);
                            },
                          ),
                        ),
                        SizedBox(
                          height: MySize.md,
                        ),
                        Center(
                          child: Column(
                            children: [
                              // Button with color and shadow
                              Container(
                                width: double.infinity,
                                margin:
                                    EdgeInsets.symmetric(horizontal: MySize.md),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    String fullPhoneNumber = '${controller.phoneController.value.countryCode}${controller.phoneController.value.nsn}';

                                    await controller.signup(
                                      controller.emailController.text,
                                      controller.passwordController.text,
                                      controller.confirmPasswordController.text,
                                      fullPhoneNumber, // استخدام value.number هنا
                                      controller.firstNameController.text,
                                      controller.lastNameController.text,
                                      controller.middelNameController.text,
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red[700],
                                    // Background color
                                    elevation: 5,
                                    // Shadow
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10), // Rounded corners
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'register'.tr,
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: MySize.fontSizeLg,
                                        ),
                                      ),
                                      SizedBox(
                                        width: MySize.sm,
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: AppColors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: MySize.md),
                              Wrap(
                                alignment: WrapAlignment.center,
                                children: [
                                  Text(
                                    'i_alrady'.tr,
                                    style:
                                        TextStyle(fontSize: MySize.fontSizeSm),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.to(LoginScreen());
                                    },
                                    child: Text(
                                      'log_in'.tr,
                                      style: TextStyle(
                                          color: AppColors.primeryColor,
                                          fontSize: MySize.fontSizeSm),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
