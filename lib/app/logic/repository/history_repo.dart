import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/config/app_module.dart';
import 'package:flutter_app/app/logic/domain/api_path.dart';
import 'package:http/http.dart' as http;

class HistoryRepo {
  // List<History> list = [];
  static Future getHistory(String idUsers) async {
    final response = await http.get(
      ApiPath.getAllHistoty(idUsers),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      return data;
    } else {
      AppModule.contextToast(
        msg: "Koneksimu terputus",
        isSuccess: false,
        isBottom: false,
        shortTime: false,
      );
    }
  }
}
