import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/config/app_module.dart';
import 'package:flutter_app/app/logic/models/product.dart';
import 'package:flutter_app/app/logic/repository/favourite_repo.dart';

class Favorite extends ChangeNotifier {
  final deviceInfo = AppModule.deviceInfo;
  List<Product> productlist = [];
  var loading = false;
  var _isNull = true;
  bool get isNull => _isNull == true;
  String _deviceId;
  // String get deviceId => _deviceId;

  favouriteTapped(BuildContext context, int idProduct) async {
    loading = true;
    notifyListeners();
    print("Ini device Id nya = $_deviceId");
    final data =
        await FavouriteRepo.addUserFavorite(_deviceId, idProduct.toString());
    print(data);
    int value = data["value"];
    String message = data["message"];
    if (value == 1) {
      if (data != null) {
        getUserFavourite(context);
        loading = false;
        _isNull = true;
        AppModule.contextToast(
          msg: message,
          backColor: Colors.green[400],
        );
      } else {
        getUserFavourite(context);
        loading = false;
        _isNull = false;
        print(message);
        AppModule.contextToast(
          msg: message,
          isSuccess: false,
          backColor: Colors.red[600],
        );
      }
    } else {
      loading = false;
      _isNull = true;
      print(message);
      AppModule.snackBarInfo(
        context,
        msg: message,
        backColor: Colors.red[600],
      );
    }
    notifyListeners();
  }

  getDeviceInfo() async {
    final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    _deviceId = androidInfo.androidId;
    print("Device Info dari Favorite: $_deviceId");
    notifyListeners();
  }

  getUserFavourite(BuildContext context) async {
    await getDeviceInfo();
    productlist.clear();
    loading = true;
    notifyListeners();
    final data = await FavouriteRepo.getFavorite(_deviceId);
    if (data == null) {
      _isNull = true;
      loading = false;
    } else {
      print("INI DATA WISHLIST : $data");
      for (Map json in data) {
        productlist.add(Product.fromJson(json));
        _isNull = false;
      }
    }
    loading = false;
    notifyListeners();
  }
}
