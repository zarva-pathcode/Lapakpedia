import 'package:flutter_app/app/logic/models/product.dart';

class Category {
  String id;
  String categoryName;
  String status;
  DateTime createDate;
  List<Product> product;

  Category({
    this.id,
    this.categoryName,
    this.status,
    this.createDate,
    this.product,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    var list = json["product"] as List;
    List<Product> productList = list.map((e) => Product.fromJson(e)).toList();

    return Category(
      id: json["id"],
      categoryName: json["categoryName"],
      status: json["status"],
      createDate: json["createdDate"],
      product: productList,
    );
  }
}
