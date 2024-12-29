import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:test1/core/const_data/app_colors.dart';
import 'package:test1/core/const_data/app_image.dart';
import 'package:test1/core/const_data/my_size.dart';
import 'package:test1/view/home_screen/screen/home_screen.dart';
import 'package:test1/view/login_screen/controller/login_controller.dart';
import 'package:test1/view/register_screen/screen/register_screen.dart';
import 'package:test1/widgets/text_cutom.dart';
import 'package:test1/widgets/text_form_custom.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text('sign_in'.tr,
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
        init: LoginController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Container(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [


                        SizedBox(height: MySize.la),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.toggleEmailLoginMethod();
                                controller.togglePhoneLoginMethod();
                              },
                              child: TextCustom(
                                text: controller.isPhoneLogin.value
                                    ? "Sign in with email?"
                                    : "Sign in with phone number?",
                                color: Colors.blue,
                                size: MySize.fontSizeSm,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: MySize.md),
                        if (!controller.isEmailLogin.value) ...[
                          TextCustom(
                              text: 'email'.tr,
                              color: AppColors.black,
                              size: MySize.fontSizeLg),
                          SizedBox(height: MySize.md),
                          TextFormCustom(
                            controller: controller.emailController,
                            suffixIcon: Icons.email,
                            hintText: 'hint_email_name'.tr,
                            labelText: 'hint_email_name'.tr,
                            labelColor: AppColors.red9,
                            fillColor: AppColors.white,
                            isFilled: true,
                            iconColor: AppColors.red9,
                            typeKeyboard: TextInputType.emailAddress,
                            validator: (value) {
                              return controller.emailValidator(value!);
                            },
                            borderColor: AppColors.red9,
                            borderSize: MySize.borderRadius,
                            hintColor: AppColors.red3,
                          ),
                        ],
                        if (controller.isPhoneLogin.value) ...[
                          TextCustom(
                              text: 'phone'.tr,
                              color: AppColors.black,
                              size: MySize.fontSizeLg),
                          SizedBox(height: MySize.md),
                          PhoneFormField(
                            controller: controller.phoneController,
                            decoration: InputDecoration(
                              labelText: 'hint_phone'.tr,
                              labelStyle: TextStyle(color: AppColors.red9),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    MySize.borderRadius),
                                borderSide: BorderSide(color: AppColors.red9),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.red9),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.red9),
                              ),
                            ),
                          ),
                        ],
                        SizedBox(height: MySize.md),
                        Text(
                          'password'.tr,
                          style: TextStyle(
                              color: AppColors.black,
                              fontSize: MySize.fontSizeLg),
                        ),
                        SizedBox(height: MySize.md),
                        Obx(
                          () => TextFormField(
                            controller: controller.passwordController,
                            decoration: InputDecoration(
                              labelText: 'hint_password'.tr,
                              hintText: 'hint_password'.tr,
                              labelStyle: TextStyle(color: AppColors.red9),
                              hintStyle: TextStyle(color: Colors.red[300]),
                              prefixIcon:
                                  Icon(Icons.lock, color: AppColors.red9),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.isPasswordVisible.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: AppColors.red9,
                                ),
                                onPressed:
                                    controller.togglePasswordVisibility,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.red9),
                                borderRadius: BorderRadius.circular(
                                    MySize.borderRadius),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.red9),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              fillColor: AppColors.white,
                              // Set background color
                              filled: true, // Enable background color
                            ),
                            obscureText: !controller.isPasswordVisible.value,
                            style: TextStyle(color: AppColors.black),
                            // Set text color
                            // validator: (value) {
                            //   return controller
                            //       .passwordValidator(value ?? '');
                            // },
                          ),
                        ),
                        SizedBox(
                          height: MySize.md,
                        ),
                        SizedBox(
                          height: MySize.xl * 2,
                        ),
                        Center(
                          child: Column(
                            children: [
                              // Button with color and shadow
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(
                                    horizontal: MySize.md),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final phone = controller.phoneController.value; // Ensure this is a PhoneNumber
                                    await controller.signIn(
                                      controller.emailController.text,
                                      controller.passwordController.text,
                                      phone,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'b_continue'.tr,
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: MySize.fontSizeLg,
                                        ),
                                      ),
                                      SizedBox(width: MySize.sm),
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
                                  Text('you_do'.tr),
                                  TextButton(
                                    onPressed: () {
                                      Get.to(RegisterScreen());
                                    },
                                    child: Text(
                                      'create'.tr,
                                      style: TextStyle(
                                          color: AppColors.primeryColor),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: MySize.md),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
