import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smbs_machine_test/core/services/api_services.dart';

class LoginServices with ChangeNotifier {
  final Dio dio = ApiServices.getInstance();

  Future<bool> userLogin({
    required String email,
    required String password,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = 'https://reqres.in/api/login';
    try {
      var response = await dio.post(
        url,
        data: {"email": email, "password": password},
      );
      final decodedData = jsonDecode(response.data);
      prefs.setString('token', decodedData['token']);
      String token = prefs.getString('token') ?? '';
      log(decodedData['token']);
      log(token);
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        notifyListeners();
        return true;
      } else {
        notifyListeners();
        return false;
      }
    } on Exception catch (e) {
      log('Error: $e');
      return false;
    }
  }
}
