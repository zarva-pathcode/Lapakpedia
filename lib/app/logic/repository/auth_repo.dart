import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/config/app_module.dart';
import 'package:flutter_app/app/logic/domain/api_path.dart';
import 'package:http/http.dart' as http;

class AuthRepo {
  static Future loginGoogle(
    String email,
    String token,
  ) async {
    final response = await http.post(ApiPath.googleLogin, body: {
      "email": email,
      "token": token,
    });
    if (response.statusCode == 200) {
      print("Status Code : ${response.statusCode}");
      final data = json.decode(response.body);
      print("Data Repo : $data");
      return data;
    } else {
      print("Status Code : ${response.statusCode}");
      AppModule.showInfo(
        msg: "Gagal, Pastikan anda memiliki internet yang baik",
        color: Colors.red,
      );
    }
  }

  static Future loginPassword(
      String email, String password, String token) async {
    final response = await http.post(ApiPath.manualLogin, body: {
      "email": email,
      "password": password,
      "token": token,
    });
    if (response.statusCode == 200) {
      print("Status Code : ${response.statusCode}");
      final data = json.decode(response.body);
      print("Data Repo : $data");
      return data;
    } else {
      print("Status Code : ${response.statusCode}");
      AppModule.showInfo(
        msg: "Gagal, Pastikan anda memiliki internet yang baik",
        color: Colors.red,
      );
    }
  }

  static Future userReg(
    String emailVal,
    String password,
    String fullname,
    String phone,
    String token,
  ) async {
    var response = await http.post(ApiPath.register, body: {
      "email": emailVal,
      "password": password,
      "fullname": fullname,
      "phone": phone,
      "token": token,
    });
    if (response.statusCode == 200) {
      print("Status Code : ${response.statusCode}");
      final data = json.decode(response.body);
      print("Data Repo : $data");
      return data;
    } else {
      print("Status Code : ${response.statusCode}");
      AppModule.showInfo(
          msg: "Gagal, Pastikan anda memiliki internet yang baik",
          color: Colors.red);
    }
  }
}
