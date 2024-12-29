import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'check_internet.dart';
import 'status_request.dart';

class Crud {
  Future<Either<StatusRequest, Map<String, dynamic>>> postData(String url,
      Map<String, dynamic> data, Map<String, String> headers) async {
    try {
      if (await checkInternet()) {
        var response = await http.post(
          Uri.parse(url),
          body: jsonEncode(data),
          headers: headers,
        );

        print(response);

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map<String, dynamic> responseBody = jsonDecode(response.body);
          print(response.body);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (_) {
      print(_);
      return const Left(StatusRequest.serverFailure);
    }
  }
}
