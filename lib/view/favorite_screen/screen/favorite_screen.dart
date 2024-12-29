import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1/core/const_data/my_size.dart';
import 'package:test1/core/service/link.dart';
import 'package:test1/view/favorite_screen/controller/favorite_controller.dart';
import 'package:test1/widgets/text_cutom.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite_Jobs'.tr),
      ),
      body: GetBuilder(
        init: FavoriteController(),
        builder: (controller) {
          return ListView.builder(
            itemCount:controller.dataJobs.length,
            padding: const EdgeInsets.all(MySize.md),
            itemBuilder: (context, index) {
              final job = controller.dataJobs[index]?? "null";
              return Container(
                margin: const EdgeInsets.only(bottom: MySize.md),
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
                            text: '${job['title']}'??"null",
                            size: MySize.fontSizeLg,
                            fontW: FontWeight.bold,
                          ),
                          Spacer(),
                          Image.network('${AppLink.appRoot}/company_logos/${job['company_logo']}'??"null",width: 40,height: 30,),

                        ],
                      ),
                      TextCustom(
                        text:'${job['company_name']}/${job['city_name']}/${job['state_name']}'??"null",
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
                              text:'\$${job["salary_from"]} - \$${job["salary_to"]}'?? "null",
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
                      //     TextCustom(text: "Today"),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
