import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/config/app_module.dart';
import 'package:flutter_app/app/logic/provider/auth_data.dart';
import 'package:flutter_app/app/logic/models/category.dart';
import 'package:flutter_app/app/logic/models/product.dart';
import 'package:flutter_app/app/logic/domain/api_path.dart';
import 'package:flutter_app/app/logic/provider/favorite_provider.dart';
import 'package:flutter_app/app/logic/repository/product_repo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_native_image/flutter_native_image.dart';

class ProductProv with ChangeNotifier {
  List<Category> listCategory = [];
  List<Product> listProduct = [];
  List<Product> searchList = [];
  String productName, desc, qty, price, message, username, selectedDate;
  DateTime dateNow = DateTime.now();
  int value;
  File image;
  Category category;
  int get index => _index;

  var loadingProduct = false;
  var loadingCategory = false;
  var _index = 0;
  var filter = false;
  var formatDate = DateFormat("yyyy-MM-dd");

  void filterTapped(int i) {
    filter = true;
    _index = i;
    notifyListeners();
  }

  onSearch(String text) async {
    searchList.clear();
    notifyListeners();
    if (text.isEmpty) {}

    listProduct.forEach((e) {
      if (e.productName.toLowerCase().contains(text)) {
        searchList.add(e);
      }
    });

    notifyListeners();
  }

  Future selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: dateNow,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != dateNow) {
      dateNow = pickedDate;
      selectedDate = formatDate.format(dateNow);
    }
    notifyListeners();
  }

  void pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    File compressedFile =
        await FlutterNativeImage.compressImage(image.path, quality: 50);
    this.image = compressedFile;
    notifyListeners();
  }

  getProduct(BuildContext context) async {
    listProduct.clear();
    loadingProduct = true;
    notifyListeners();
    final response = await http.get(ApiPath.getAllData);
    final data = jsonDecode(response.body);

    for (Map json in data) {
      listProduct.add(Product.fromJson(json));
    }
    getDataForUser(context);
    Provider.of<Favorite>(context, listen: false).getDeviceInfo();
    loadingProduct = false;
    notifyListeners();
  }

  getCategory(BuildContext context) async {
    filter = false;
    _index = 0;
    listCategory.clear();
    loadingCategory = true;
    notifyListeners();
    final data = await ProductRepo.getProductCategory();

    for (Map json in data) {
      listCategory.add(Category.fromJson(json));
      print("Gotted the category");
    }
    loadingCategory = false;
    notifyListeners();
  }

  getDataForUser(BuildContext context) {
    final _authLevel = Provider.of<AuthData>(context, listen: false).level;
    print("Auth Data : $_authLevel");
    if (_authLevel != 2) {
      filter = false;
      _index = 0;
    }
  }

  addProduct(BuildContext context) async {
    if (productName.length != 0 ||
        desc.length != 0 ||
        qty.length != 0 ||
        price.length != 0 ||
        dateNow != null ||
        image != null) {
      loadingProduct = true;
      notifyListeners();
      var resp = await ProductRepo.addProduct(
        productName,
        desc,
        qty,
        price,
        image,
        Provider.of<AuthData>(context, listen: false).uid,
        category.id,
      );
      value = resp["value"];
      message = resp["message"];
      print("Value = $value");
      if (value == 1) {
        loadingProduct = false;
        AppModule.showInfo(
          msg: message,
          color: Colors.green[600],
        );
        getProduct(context);
        Navigator.pop(context);
      } else {
        loadingProduct = false;
        AppModule.showInfo(
          msg: message,
          color: Colors.red[600],
        );
      }
    } else {
      AppModule.showInfo(
        msg: "Make sure you fill all the form",
        color: Colors.red,
      );
    }
    notifyListeners();
  }

  editProduct(
    BuildContext context, {
    String idCategory,
    String namaProduk,
    String description,
    String quantity,
    String harga,
    String idProduct,
  }) async {
    loadingProduct = true;
    notifyListeners();
    var resp = await ProductRepo.editProduct(
      namaProduk,
      desc,
      quantity,
      harga,
      image,
      idProduct,
      Provider.of<AuthData>(context, listen: false).uid.toString(),
      category.id,
    );
    value = resp["value"];
    message = resp["message"];
    if (value == 1) {
      loadingProduct = false;
      AppModule.showInfo(
        msg: message,
        color: Colors.green[600],
      );
      image = null;
      getProduct(context);
      Navigator.pop(context);
    } else {
      loadingProduct = false;
      AppModule.showInfo(msg: message, color: Colors.red);
    }
    notifyListeners();
  }

  deleteProduct(BuildContext context, int idProduct) async {
    var resp = await ProductRepo.deleteProduct(idProduct);
    value = resp["value"];
    message = resp["message"];
    if (value == 1) {
      getProduct(context);
      AppModule.showInfo(
        msg: message,
        color: Colors.green[600],
      );
    } else {
      AppModule.showInfo(
        msg: message,
        color: Colors.red[600],
      );
    }

    notifyListeners();
  }

  setClear() {
    productName = null;
    desc = null;
    qty = null;
    price = null;
    image = null;
    notifyListeners();
  }
}
