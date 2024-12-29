import 'package:flutter/material.dart';
import 'package:test1/core/const_data/app_colors.dart';
import 'package:test1/core/const_data/my_size.dart';

class CustomCardDroup extends StatefulWidget {
  final String? text;
  final List<Map<String, dynamic>> list;

  const CustomCardDroup({
    Key? key,
    this.text = '',
    required this.list,
  }) : super(key: key);

  @override
  _CustomCardDroupState createState() => _CustomCardDroupState();
}

class _CustomCardDroupState extends State<CustomCardDroup> {
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MySize.borderRadius),
        border: Border.all(color: AppColors.black),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButton<String>(
          isExpanded: true,
          value: selectedItem,
          underline: SizedBox(),
          hint: Text(widget.text ?? 'Select an item'),
          style: TextStyle(
            color: AppColors.black,
            fontSize: MySize.fontSizeMd,
          ),
          items: widget.list.map((item) {
            return DropdownMenuItem<String>(
              value: item['id'].toString(), // استخدم id كقيمة
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(item['name']), // استخدم name كنص مرئي
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedItem = value; // تحديث العنصر المحدد
            });
          },
        ),
      ),
    );
  }
}
