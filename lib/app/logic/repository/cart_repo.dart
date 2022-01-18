import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/config/app_module.dart';
import 'package:flutter_app/app/logic/domain/api_path.dart';
import 'package:http/http.dart' as http;

class CartRepo {
  static Future getTmpCart(uniqueId) async {
    final response = await http.get(
      ApiPath.getAllTmpCart(uniqueId),
    );

    final data = jsonDecode(response.body);
    return data;
  }

  static Future getTotalCart(uniqueId) async {
    final response = await http.get(
      ApiPath.getTotalCart(uniqueId),
    );

    final data = jsonDecode(response.body)[0];
    return data;
  }

  static Future getSumTotalCart(uniqueId) async {
    final response = await http.get(
      ApiPath.getSumTotalCart(uniqueId),
    );

    final data = jsonDecode(response.body)[0];
    print("Data dari Repo $data");
    return data;
  }

  static Future addToCart(String deviceId, int idProduct) async {
    final response = await http.post(
      ApiPath.addTmpCart,
      body: {
        "uniqueId": deviceId,
        "idProduct": idProduct.toString(),
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      print(response.statusCode);
      AppModule.showInfo(
        msg: "Failed, make sure you have a good connection",
        color: Colors.red,
      );
      return;
    }
  }

  static Future updateQty(
      String deviceId, String idProduct, String type) async {
    final response = await http.post(
      ApiPath.updateCartQty,
      body: {
        "uniqueId": deviceId,
        "idProduct": idProduct,
        "type": type,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("Data dari Repo $data");
      return data;
    } else {
      print(response.statusCode);
      AppModule.showInfo(
        msg: "Failed, make sure you have a good connection",
        color: Colors.red,
      );
      return;
    }
  }

  static Future checkout(String idUsers, String uniqueId) async {
    final response = await http.post(
      ApiPath.cartCheckout,
      body: {
        "idUsers": idUsers,
        "uniqueId": uniqueId,
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      print(response.statusCode);
      AppModule.showInfo(
        msg: "Failed, make sure you have a good connection",
        color: Colors.red,
      );
      return;
    }
  }
}
