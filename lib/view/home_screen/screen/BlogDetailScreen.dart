import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;

class BlogDetailScreen extends StatelessWidget {
  final Map<String, dynamic> blog;

  BlogDetailScreen({required this.blog});

  String _convertHtmlToText(String html) {
    final document = parse(html);
    return document.body?.text ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(blog['heading']),
      ),
      body: SingleChildScrollView( // إضافة SingleChildScrollView هنا
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                'https://www.jobaaty.com/uploads/blogs/${blog['image']}',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              SizedBox(height: 20),
              Text(
                blog['heading'],
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                _convertHtmlToText(blog['content']),
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
