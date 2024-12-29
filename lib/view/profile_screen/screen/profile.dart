import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1/core/const_data/app_image.dart';
import 'package:test1/core/const_data/my_size.dart';
import 'package:test1/view/infomedia_profile_sceen/controller/infomedia_profile_controller.dart';
import 'package:test1/view/profile_screen/controller/profile_controller.dart';
import 'package:test1/view/profile_screen/widgets/AddCvPopup.dart';
import 'package:test1/view/profile_screen/widgets/about_me.dart';
import 'package:test1/widgets/text_cutom.dart';

import '../widgets/cv_card.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(InfomediaProfileController()); // تهيئته مرة واحدة عند تحميل الشاشة

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: TextCustom(
            text: 'Profile',
            size: MySize.fontSizeLg,
            fontW: FontWeight.bold,
          ),
        ),
      ),
      body: GetBuilder<ProfileController>(
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
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
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
              : SingleChildScrollView(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: Image.network(
                              controller.infoProfile != null && controller.infoProfile['cover_image'] != null && controller.infoProfile['cover_image'].isNotEmpty
                                  ? 'https://www.jobaaty.com/user_images/${controller.infoProfile['cover_image']}'
                                  : 'https://upload.wikimedia.org/wikipedia/commons/b/b9/No_Cover.jpg',
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            child: DefaultTabController(
                              length: 4,
                              child: Column(
                                children: [
                                  SizedBox(height: 90),
                                  TabBar(
                                    tabs: [
                                      Tab(text: "CV"),
                                      Tab(text: "About Me"),
                                      Tab(text: "Summary"),
                                      Tab(text: "Video"),
                                    ],
                                  ),
                                  Container(
                                    height: 400,
                                    child: TabBarView(
                                      children: [
                                        // تبويب CV
                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) => AddCvPopup(),
                                                  );
                                                },
                                                child: Text('Upload CV'),
                                              ),
                                            ),
                                            Expanded(
                                              child: ListView.builder(
                                                padding: EdgeInsets.all(10),
                                                itemCount: controller.profileCv.length,
                                                itemBuilder: (context, index) {
                                                  final cv = controller.profileCv[index];
                                                  return CvCard(
                                                    cvTitle: cv['title'],
                                                    defaultStatus: cv['is_default'] == 1 ? 'Default' : 'Not Default',
                                                    addedDate: cv['created_at'],
                                                    onDelete: () {
                                                      controller.deleteCv(cv['id']);
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),

                                        // تبويب About Me
                                        AboutMee(
                                          controllerFirstName: controller.controllerFirstN,
                                          controllerLastName: controller.controllerLastN,
                                          controllerMiddleName: controller.controllerMiddleN,
                                          controllerEmail: controller.controllerEmail,
                                          controllerPhone: controller.controllerPhone,
                                          controllerPassword: controller.controllerPassword,
                                          controllerDMY: controller.controllerDMY,
                                          controllerCurrentSalary: controller.controllerCurrentSalary,
                                          controllerExpectedSalary: controller.controllerExpectedSalary,
                                          controllerNationalIdCard: controller.controllerNationalIdCard,
                                          controllerStatID: controller.controllerStatID,
                                          controllerStreetAddress: controller.controllerStreetAddress,
                                        ),

                                        // تبويب Summary
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: TextField(
                                                  controller: controller.summaryController,
                                                  maxLines: null,
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    labelText: 'Enter your summary',
                                                    hintText: 'Write your summary here...',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              ElevatedButton(
                                                onPressed: () {
                                                  if (controller.summaryController.text.isEmpty) {
                                                    Get.snackbar('Error', 'Summary cannot be empty',
                                                      snackPosition: SnackPosition.BOTTOM,
                                                    );
                                                  } else {
                                                    controller.updatesummry();
                                                  }
                                                },
                                                child: Text('Save'),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // تبويب Video
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: SingleChildScrollView(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                final infomediaController = Get.find<InfomediaProfileController>();

                                                // استدعاء الدالة pickVideo
                                                infomediaController.pickVideo();

                                               Get.snackbar('success', 'Video Update Success',
                                               snackPosition: SnackPosition.BOTTOM,);
                                              },
                                              child: const Text('Upload Video'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 120,
                        left: 0,
                        child: Row(
                          children: [
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  radius: 65,
                                  backgroundImage:
                                      NetworkImage( controller.infoProfile['image'] != null && controller.infoProfile['image'].isNotEmpty
                                          ? 'https://jobaaty.q-agancy.ae/public/user_images/${controller.infoProfile['image']}' :
                                      'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1200px-No_image_available.svg.png',
                                       )
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: IconButton(
                                    icon: Icon(Icons.camera_alt,
                                        color: Colors.red),
                                    onPressed: () {
                                      controller.showImageOptions(context);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 10),
                            Column(
                              children: [
                                SizedBox(height: 80),
                                TextCustom(
                                  text:
                                  '${controller.infoProfile['name']}',
                                  size: MySize.fontSizeXlg,
                                  fontW: FontWeight.bold,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.email),
                                    SizedBox(width: 10),
                                    TextCustom(
                                      text:
                                         '${controller.infoProfile['email']}',
                                      size: MySize.fontSizeMd,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
