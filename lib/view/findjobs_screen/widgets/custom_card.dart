import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final IconData icon;
  final String? text;
  final Function()? func;

  const CustomCard({
    Key? key,
    required this.icon,
    this.text = '',
    this.func,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0), // استخدم MySize.sm حسب حاجتك
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(text!),
              IconButton(
                icon: Icon(icon),
                onPressed: () {
                  func?.call(); // استدعاء الدالة إذا كانت غير فارغة
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
