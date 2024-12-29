import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileInfo extends StatelessWidget {
  final String name;
  final String date;
  final String email;
  final String location;
  final String phone;
  final String facebook;
  final String twitter;
  final String linkedin;
  final String googlePlus;
  final String pinterest;

  const ProfileInfo({
    super.key,
    required this.name,
    required this.date,
    required this.email,
    required this.location,
    required this.phone,
    required this.facebook,
    required this.twitter,
    required this.linkedin,
    required this.googlePlus,
    required this.pinterest,
  });

  void _launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: Icon(Icons.person, color: Colors.red),
                title: Text(
                  'name_company'.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  name,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: Icon(Icons.calendar_today, color: Colors.red),
                title: Text(
                  'established_in'.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  date,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: Icon(Icons.email, color: Colors.red),
                title: Text(
                  'email'.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  email,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 10),
    Card(
    elevation: 3,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
    ),
    child: ListTile(
    leading: Icon(Icons.location_on, color: Colors.red),
    title: Text(
    'location'.tr,
    style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    ),
    ),
    subtitle: Text(
    location,
    style: TextStyle(fontSize: 16),
    ),
    ),
    ),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: Icon(Icons.phone, color: Colors.red),
                title: Text(
                  'company_phone'.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  phone,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 10),

            // Social media icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
                  onPressed: () => _launchURL(Uri.parse(facebook)),
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.twitter, color: Colors.blue),
                  onPressed: () => _launchURL(Uri.parse(twitter)),
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.linkedin, color: Colors.blue),
                  onPressed: () => {
                    _launchURL(Uri.parse(linkedin)),
                    print('Launching URL: ${Uri.parse(linkedin)}'),
                  },
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.googlePlus, color: Colors.red), // إذا لم يكن هناك Google Plus، يمكن استخدام أي أيقونة أخرى
                  onPressed: () => _launchURL(Uri.parse(googlePlus)),
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.pinterest, color: Colors.red),
                  onPressed: () => _launchURL(Uri.parse(pinterest)),

                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
