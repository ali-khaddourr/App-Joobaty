import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:test1/core/service/link.dart';
import 'package:test1/view/details_company/controller/details_company_controller.dart';
import 'package:test1/view/details_company/view/company_detail.dart';
import 'package:test1/view/findjobs_screen/controller/find_jobs_controller.dart';

class CompanyDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DetailsCompanyController controller = Get.put(DetailsCompanyController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Companies'.tr),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: controller.Companies.length,
          itemBuilder: (context, index) {
            var company = controller.Companies[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                leading: company['logo'] != null
                    ? Image.network(
                  '${AppLink.appRoot}/company_logos/${company['logo']}',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                )
                    : Icon(Icons.business),
                title: Text(company['name'] ?? 'N/A'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(company['location'] ?? 'No location available.'),
                    SizedBox(height: 8),

                  ],
                ),
                onTap: () async {
                  await controller.fetchCompanyDetails(company['slug']);
                  Get.to(CompanyDetail());
                },
              ),
            );
          },
        );
      }),
    );
  }
}
