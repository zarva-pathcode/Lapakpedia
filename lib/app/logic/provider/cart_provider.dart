import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/config/app_module.dart';
import 'package:flutter_app/app/logic/models/cart.dart';
import 'package:flutter_app/app/logic/models/payment_method.dart';
import 'package:flutter_app/app/logic/provider/auth_data.dart';
import 'package:flutter_app/app/logic/repository/cart_repo.dart';
import 'package:flutter_app/app/ui/screens/user_page/cart_page.dart';
import 'package:flutter_app/app/ui/screens/user_page/navigator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CartProvider extends ChangeNotifier {
  final deviceInfo = AppModule.deviceInfo;
  String qty, price, message, uniqueId, _deviceId;
  int value;
  var totalCart = "0";
  int sumTotalCart;
  var loadingCart = false;
  var loadingTotal = false;
  var loadingCount = false;
  var _isNull = false;
  var selectedItem;
  bool get isNull => _isNull == true;
  List<Cart> cartList = [];
  List<PaymentMethod> get paymentMethod => _paymentList;

  List<PaymentMethod> _paymentList = [
    PaymentMethod("Amazon Pay", FontAwesomeIcons.amazonPay),
    PaymentMethod("Credit Card", FontAwesomeIcons.creditCard),
    PaymentMethod("Google Pay", FontAwesomeIcons.googlePay),
    PaymentMethod("Apple Pay", FontAwesomeIcons.applePay),
    PaymentMethod("Paypal", FontAwesomeIcons.paypal)
  ];

  getDeviceInfo() async {
    final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    _deviceId = androidInfo.androidId;
    print("Device Info dari Authentication: $_deviceId");
    notifyListeners();
  }

  addTmpItemCart(BuildContext context, int idProduct) async {
    await getDeviceInfo();
    final resp = await CartRepo.addToCart(
      _deviceId,
      idProduct,
    );
    print(resp["message"]);
    value = resp['value'];
    message = resp['message'];
    if (value == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            message,
            style: AppModule.regularText.copyWith(color: Colors.white),
          ),
          action: SnackBarAction(
              textColor: Colors.white,
              label: "lihat",
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => CartPage()));
              }),
        ),
      );

      getTotalCart();
      // Navigator.pop(context);
      getCartItem(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
      getCartItem(context);
    }
    notifyListeners();
  }

  final totalItem = List<Cart>();

  getCartItem(BuildContext context) async {
    loadingCart = true;
    await getDeviceInfo();
    cartList.clear();
    notifyListeners();
    var data = await CartRepo.getTmpCart(
      _deviceId,
    );
    if (data.length != 0) {
      for (Map json in data) {
        cartList.add(Cart.fromJson(json));
      }
      getSumAmountCart();
      _isNull = false;
      loadingCart = false;
    } else {
      _isNull = true;
      loadingCart = false;
    }
    loadingCart = false;
    notifyListeners();
  }

  updateQty(BuildContext context, String idProduct, String type) async {
    final data = await CartRepo.updateQty(_deviceId, idProduct, type);
    print("ini Datanya $data");
    value = data["value"];
    message = data["message"];
    if (value == 1) {
      await getCartItem(context);
    } else {
      AppModule.showInfo(msg: message, color: Colors.red[600]);
    }
    notifyListeners();
  }

  getTotalCart() async {
    loadingTotal = true;
    await getDeviceInfo();
    notifyListeners();
    var data = await CartRepo.getTotalCart(_deviceId);
    print("Total CART $data");
    totalCart = data["total"];
    loadingTotal = false;

    notifyListeners();
  }

  getSumAmountCart() async {
    loadingCount = true;
    notifyListeners();
    var data = await CartRepo.getSumTotalCart(_deviceId);
    print("ini Datanya $data");
    sumTotalCart = int.parse(data['total']) ?? 0;
    loadingCount = false;
    notifyListeners();
  }

  checkout(BuildContext context, String payment, int amount) async {
    final data = await CartRepo.checkout(
        Provider.of<AuthData>(context, listen: false).uid.toString(),
        _deviceId);
    print("Data : $data");
    value = data["value"];
    message = data["message"];
    if (value == 1) {
      getCartItem(context);
      getTotalCart();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: AppModule.mediumText.copyWith(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  itemTapped(int index) {
    selectedItem = index;
    notifyListeners();
  }
}
