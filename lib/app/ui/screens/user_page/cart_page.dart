import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/config/app_module.dart';
import 'package:flutter_app/app/logic/models/payment_method.dart';
import 'package:flutter_app/app/logic/provider/auth_data.dart';
import 'package:flutter_app/app/logic/provider/cart_provider.dart';
import 'package:flutter_app/app/ui/screens/login_screen.dart';
import 'package:flutter_app/app/ui/widgets/user_widget.dart/app_appbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int _selectedItem;
  String pay;
  @override
  Widget build(BuildContext mainContext) {
    final _cart = Provider.of<CartProvider>(context, listen: false);
    final _authD = Provider.of<AuthData>(context, listen: false);
    final RefreshController _refreshController =
        RefreshController(initialRefresh: true);
    void _onRefresh() async {
      Provider.of<CartProvider>(context, listen: false).getCartItem(context);
      _refreshController.refreshCompleted();
    }

    void selectCard(String method, int i) {
      _selectedItem = i;
      pay = method;
      print(pay);
      setState(() {});
    }

    void _onLoading() async {
      await Future.delayed(Duration(milliseconds: 1000));
      _refreshController.loadComplete();
    }

    var placeHolder = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset("assets/images/default_image.jpg",
              fit: BoxFit.cover)),
    );

    List<PaymentMethod> _paymentList = [
      PaymentMethod("Amazon Pay", FontAwesomeIcons.amazonPay),
      PaymentMethod("Credit Card", FontAwesomeIcons.creditCard),
      PaymentMethod("Google Pay", FontAwesomeIcons.googlePay),
      PaymentMethod("Apple Pay", FontAwesomeIcons.applePay),
      PaymentMethod("Paypal", FontAwesomeIcons.paypal)
    ];

    return SafeArea(
      child: Scaffold(
        body: Consumer<CartProvider>(
          builder: (context, cart, ch) => SmartRefresher(
            physics: BouncingScrollPhysics(),
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: ListView(
              children: [
                SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: MyAppBar(
                    header: "Keranjang Kamu",
                  ),
                ),
                SizedBox(
                  height: cart.loadingCart ? 240 : 30,
                ),
                cart.loadingCart
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : cart.isNull
                        ? Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 240,
                                ),
                                Icon(
                                  Icons.shopping_basket_rounded,
                                  size: 80,
                                  color: Colors.grey[300],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Keranjang Kamu Kosong nih",
                                  style: AppModule.regularText.copyWith(
                                      color: Colors.grey[300],
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        : SizedBox(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: cart.cartList.length,
                              itemBuilder: (context, i) => Container(
                                margin: EdgeInsets.symmetric(horizontal: 24),
                                padding: EdgeInsets.symmetric(vertical: 16),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey[200],
                                    ),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        cart.cartList[i].image == null
                                            ? placeHolder
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: Image.network(
                                                  "http://firsttouch.my.id/ecommerce/upload/${cart.cartList[i].image}",
                                                  height: 65,
                                                  width: 80,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          cart.cartList[i].productName,
                                          style: AppModule.regularText,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Rp.${AppModule.currency.format(cart.cartList[i].price)}",
                                          style: AppModule.mediumText.copyWith(
                                            color: Colors.deepOrange,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4.7,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  _cart.updateQty(
                                                    context,
                                                    cart.cartList[i].id
                                                        .toString(),
                                                    "-",
                                                  );
                                                },
                                                child: Container(
                                                  height: 20,
                                                  width: 20,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.remove,
                                                      size: 14,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                cart.cartList[i].qty.toString(),
                                                style: AppModule.regularText,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  _cart.updateQty(
                                                      context,
                                                      cart.cartList[i].id
                                                          .toString(),
                                                      "+");
                                                },
                                                child: Container(
                                                  height: 20,
                                                  width: 20,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.add,
                                                      size: 14,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                SizedBox(
                  height: 30,
                ),
                cart.cartList.length == 0
                    ? SizedBox()
                    : Container(
                        padding: EdgeInsets.only(top: 14, left: 14, right: 14),
                        height: 300,
                        margin: EdgeInsets.symmetric(horizontal: 24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Metode Pembayaran",
                              style: AppModule.mediumText,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: _paymentList.length,
                                itemBuilder: (context, i) => ListTile(
                                  onTap: () {
                                    selectCard(_paymentList[i].name, i);
                                  },
                                  leading: FaIcon(
                                    _paymentList[i].icon,
                                    color: _selectedItem == i
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                  title: Text(
                                    _paymentList[i].name,
                                    style: AppModule.regularText.copyWith(
                                        color: _selectedItem == i
                                            ? Colors.blue
                                            : Colors.grey),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Consumer<CartProvider>(
          builder: (context, cart, ch) => cart.cartList.length != 0
              ? Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, -1),
                        color: Colors.grey[200],
                        blurRadius: 2,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: 66,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Total : ",
                        style: AppModule.regularText,
                      ),
                      cart.loadingCount
                          ? SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(),
                            )
                          : Text(
                              cart.sumTotalCart != null
                                  ? "Rp. ${AppModule.currency.format(cart.sumTotalCart)}"
                                  : "Rp. 0",
                              style: AppModule.mediumText.copyWith(
                                color: Colors.deepOrange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      SizedBox(
                        width: 16,
                      ),
                      Consumer<AuthData>(
                        builder: (context, data, ch) => ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.indigo,
                            minimumSize: Size(
                              100,
                              50,
                            ),
                          ),
                          onPressed: () {
                            _selectedItem == null
                                ? AppModule.actionSnackbar(context,
                                    backColor: Colors.red,
                                    icon: FontAwesomeIcons.exclamation,
                                    msg: "Pilih metode pembayaran",
                                    label: "Oke", onTap: () {
                                    Scaffold.of(context).hideCurrentSnackBar();
                                  })
                                : data.loggedIn
                                    ? _authD.userTransac(
                                        mainContext, pay, cart.sumTotalCart)
                                    : Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          transitionDuration:
                                              Duration(milliseconds: 600),
                                          transitionsBuilder: (context,
                                              animation, animationTime, child) {
                                            animation = CurvedAnimation(
                                                parent: animation,
                                                curve: Curves.easeIn);
                                            return SlideTransition(
                                              position: Tween<Offset>(
                                                      begin: Offset(1, 0),
                                                      end: Offset.zero)
                                                  .animate(animation),
                                              child: child,
                                            );
                                          },
                                          pageBuilder: (context, animation,
                                                  animationTime) =>
                                              LoginScreen(),
                                        ),
                                      );
                          },
                          icon: Icon(Icons.check_circle_outline_rounded),
                          label: Text(
                            pay == null ? "Checkout" : pay,
                            style: AppModule.regularText.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : SizedBox(),
        ),
      ),
    );
  }
}
