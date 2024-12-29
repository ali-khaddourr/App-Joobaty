import 'dart:async';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart'as http;
class ConstData {
  static String token = '';

  static bool isLoading = false;

  static const String map_key = "";

  static Future<void> updateToken() async {
    var url = Uri.parse('aaaaaaaaaaaaalllllllllllliiiiiiiiiii');
    final response = await http.post(url,
      headers: {},
      body: {},

    );
    if(response.statusCode==200){
      final responseDecode = json.decode(response.body);


    }
    //  update request token
  }

  static Future<void> startTokenupdatedata() async {
    Timer.periodic(Duration(seconds: 20), (timer) {
      updateToken();
    });
  }
}
