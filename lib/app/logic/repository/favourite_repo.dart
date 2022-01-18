import 'dart:convert';

import 'package:flutter_app/app/logic/domain/api_path.dart';
import 'package:http/http.dart' as http;

class FavouriteRepo {
  static Future getFavorite(String deviceId) async {
    final response = await http.get(
      ApiPath.getFavorite(deviceId),
    );
    final data = jsonDecode(response.body);
    return data;
  }

  static Future addUserFavorite(String deviceId, String idProduct) async {
    final response = await http.post(
      ApiPath.addDeleteFavorite,
      body: {
        'deviceInfo': deviceId,
        'idProduct': idProduct.toString(),
      },
    );
    final data = jsonDecode(response.body);
    return data;
  }
}
