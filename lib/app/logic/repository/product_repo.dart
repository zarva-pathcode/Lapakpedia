import 'dart:convert';
import 'package:async/async.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/config/app_module.dart';
import 'package:flutter_app/app/logic/domain/api_path.dart';
import 'package:http/http.dart' as http;

class ProductRepo {
  static Future getAllProduct() async {
    final response = await http.get(ApiPath.getAllData);

    final data = jsonDecode(response.body);
    return data;
  }

  static Future getProductCategory() async {
    final response = await http.get(ApiPath.getProductCategory);

    final data = jsonDecode(response.body);
    return data;
  }

  static Future addProduct(
    String productName,
    String description,
    String qty,
    String price,
    image,
    int idUsers,
    String idCategory,
  ) async {
    var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));
    var length = await image.length();
    var req = http.MultipartRequest("POST", ApiPath.createData);
    var pic = http.MultipartFile("image", stream, length,
        filename: path.basename(image.path));

    req.fields["productName"] = productName;
    req.fields["description"] = description;
    req.fields["qty"] = qty;
    req.fields["price"] = price;
    req.fields["idUsers"] = idUsers.toString();
    req.fields["idCategory"] = idCategory;
    req.files.add(pic);

    var response = await req.send();
    var respStr = await response.stream.bytesToString();
    final data = jsonDecode(respStr);
    print("response: $data");
    return data;
  }

  static Future editProduct(
    String productName,
    String description,
    String qty,
    String price,
    image,
    String idProduct,
    String idUsers,
    String idCategory,
  ) async {
    var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));
    var length = await image.length();
    var req = http.MultipartRequest("POST", ApiPath.editData);
    var pic = http.MultipartFile("image", stream, length,
        filename: path.basename(image.path));

    req.fields['productName'] = productName;
    req.fields['description'] = description;
    req.fields['qty'] = qty;
    req.fields['price'] = price;
    req.fields['idProduct'] = idProduct;
    req.fields['idUsers'] = idUsers;
    req.fields["idCategory"] = idCategory;
    req.files.add(pic);
    var response = await req.send();

    if (response.statusCode == 200) {
      print("Data Status : Data Uploaded");
      var respStr = await response.stream.bytesToString();
      final data = jsonDecode(respStr);
      print("response: $data");
      return data;
    } else {
      print("Data Status : Fail to Uploaded");
      AppModule.showInfo(
        msg: "Failed, make sure you have a good connection",
        color: Colors.red,
      );
    }
  }

  static Future deleteProduct(int id) async {
    final response = await http.post(ApiPath.deleteData, body: {
      "idProduct": id.toString(),
    });
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
