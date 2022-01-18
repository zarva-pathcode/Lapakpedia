class Product {
  int id;
  int idCategory;
  String productName;
  String desc;
  int qty;
  int price;
  String image;
  String status;
  DateTime createDate;

  Product({
    this.id,
    this.idCategory,
    this.productName,
    this.desc,
    this.qty,
    this.price,
    this.image,
    this.status,
    this.createDate,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: int.parse(json["id"]),
      idCategory: int.parse(json["idCategory"]),
      productName: json["productName"],
      desc: json["description"],
      qty: int.parse(json["qty"]),
      price: int.parse(json["price"]),
      image: json['image'],
      status: json['status'],
      createDate: DateTime.parse(json["createDate"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "productName": productName,
        "qty": qty.toString(),
        "price": price.toString(),
      };

  // Map<String, dynamic> editToJson() => {
  //       "productName": productName,
  //       "qty": qty,
  //       "price": price,
  //       "idProduct": id,
  //     };
}
