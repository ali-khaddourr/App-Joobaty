import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:test1/view/profile_screen/controller/profile_controller.dart'; // استيراد ProfileController
import 'package:get/get.dart';

class AddCvPopup extends StatefulWidget {
  @override
  _AddCvPopupState createState() => _AddCvPopupState();
}

class _AddCvPopupState extends State<AddCvPopup> {
  final _titleController = TextEditingController(); // حقل لعنوان السيرة الذاتية
  bool isDefault = false; // الحالة الافتراضية للسيرة الذاتية
  File? selectedFile; // الملف المختار

  // دالة لاختيار ملفات PDF أو DOC
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!); // حفظ الملف المختار
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find<ProfileController>();

    return AlertDialog(
      title: Text('Add CV'), // عنوان النافذة المنبثقة
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // حقل إدخال لعنوان السيرة الذاتية
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          SizedBox(height: 10),
          // مربع اختيار لتحديد السيرة الذاتية الافتراضية
          Row(
            children: [
              Checkbox(
                value: isDefault,
                onChanged: (bool? value) {
                  setState(() {
                    isDefault = value ?? false;
                  });
                },
              ),
              Text('Set as Default'),
            ],
          ),
          SizedBox(height: 10),
          // زر لاختيار ملف السيرة الذاتية
          TextButton(
            onPressed: _pickFile,
            child: Text(selectedFile == null ? 'Pick CV File' : 'File Selected'),
          ),
        ],
      ),
      actions: [
        // زر للإغلاق
        TextButton(
          onPressed: () {
            Navigator.pop(context); // إغلاق النافذة المنبثقة
          },
          child: Text('Cancel'),
        ),
        // زر للحفظ (يمكن ربطه لاحقًا بدالة API)
        ElevatedButton(
          onPressed: () {
            controller.uploadCv(
              title: _titleController.text,
              isDefault: isDefault,
              cvFile: selectedFile,
            );
            Navigator.pop(context); // إغلاق النافذة بعد الحفظ
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
