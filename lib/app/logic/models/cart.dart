class Cart {
  int id;
  String productName;
  int qty;
  int price;
  String image;
  String status;
  DateTime createDate;
  // DateTime expDate;

  Cart({
    this.id,
    this.productName,
    this.qty,
    this.price,
    this.image,
    this.status,
    this.createDate,
    // this.expDate,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: int.parse(json["id"]),
      productName: json["productName"],
      price: int.parse(json["price"]),
      image: json['image'],
      status: json['status'],
      createDate: DateTime.parse(json["createDate"]),
      qty: int.parse(json["qty"]),
    );
  }

  // Map<String, dynamic> toJson() => {
  //       "productName": productName,
  //       "qty": qty.toString(),
  //       "price": price.toString(),
  //       "idUsers": idUsers.toString(),
  //     };

  // Map<String, dynamic> editToJson() => {
  //       "productName": productName,
  //       "qty": qty,
  //       "price": price,
  //       "idProduct": id,
  //     };
}
