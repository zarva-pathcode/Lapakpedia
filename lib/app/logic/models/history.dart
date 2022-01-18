class History {
  final String id;
  final String noInvoice;
  final String createdDate;
  final String status;
  final List<HistoryDetail> detail;

  History(
      {this.id, this.noInvoice, this.createdDate, this.status, this.detail});
  factory History.fromJson(Map<String, dynamic> data) {
    var list = data["detail"] as List;
    List<HistoryDetail> listData =
        list.map((e) => HistoryDetail.fromJson(e)).toList();
    return History(
      id: data["id"],
      noInvoice: data["noInvoice"],
      createdDate: data["createdDate"],
      status: data["status"],
      detail: listData,
    );
  }
}

class HistoryDetail {
  final String id;
  final String idProduct;
  final int qty;
  final int price;
  final String discount;
  final String productName;
  final String image;

  HistoryDetail(
      {this.id,
      this.idProduct,
      this.qty,
      this.price,
      this.discount,
      this.productName,
      this.image});

  factory HistoryDetail.fromJson(Map<String, dynamic> data) => HistoryDetail(
        id: data["id"],
        idProduct: data["idProduct"],
        qty: int.parse(data["qty"]),
        price: int.parse(data["price"]),
        discount: data["discount"],
        productName: data["productName"],
        image: data["image"],
      );
}
