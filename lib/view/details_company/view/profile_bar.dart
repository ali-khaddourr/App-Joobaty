import 'package:flutter/material.dart';
import 'package:test1/core/const_data/my_size.dart';
import 'package:test1/view/details_company/widgets/profile_info.dart';


class ProfileBar extends StatelessWidget {
  final Map<String, dynamic> companyData;

  const ProfileBar({super.key, required this.companyData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(MySize.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileInfo(
            name: companyData['name'] ?? 'N/A',
            date: companyData['established_in'] ?? 'N/A',
            email: companyData['email'] ?? 'N/A',
            location: companyData['location'] ?? 'N/A',
            phone: companyData['phone'] ?? 'N/A',
            facebook: companyData['facebook'] ?? '',
            twitter: companyData['twitter'] ?? '',
            linkedin: companyData['linkedin'] ?? '',
            googlePlus: companyData['google_plus'] ?? '',
            pinterest: companyData['pinterest'] ?? '',
          ),
          // يمكنك إضافة المزيد من المعلومات هنا إذا رغبت
        ],
      ),
    );
  }
}
