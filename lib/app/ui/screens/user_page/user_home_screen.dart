import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/config/app_module.dart';
import 'package:flutter_app/app/logic/provider/auth_data.dart';
import 'package:flutter_app/app/logic/provider/cart_provider.dart';
import 'package:flutter_app/app/logic/provider/favorite_provider.dart';
import 'package:flutter_app/app/logic/provider/history_provider.dart';
import 'package:flutter_app/app/logic/provider/product_provider.dart';
import 'package:flutter_app/app/ui/screens/user_page/cart_page.dart';
import 'package:flutter_app/app/ui/widgets/user_widget.dart/product_card.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'detail_page.dart';

class UserHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _product = Provider.of<ProductProv>(context, listen: false);
    final _cart = Provider.of<CartProvider>(context, listen: false);
    final _authData = Provider.of<AuthData>(context, listen: false);
    final _history = Provider.of<HistoryProvider>(context, listen: false);

    final RefreshController _refreshController =
        RefreshController(initialRefresh: true);
    void _onRefresh() async {
      await _authData.getPref();
      await _authData.getSaldo(context);
      _product.getProduct(context);
      _product.getCategory(context);
      _cart.getTotalCart();
      AppModule.toast.init(context);
      _refreshController.refreshCompleted();
    }

    void _onLoading() async {
      await Future.delayed(Duration(milliseconds: 1000));
      _refreshController.loadComplete();
    }

    return SafeArea(
      child: Scaffold(
        body: SmartRefresher(
          controller: _refreshController,
          onLoading: _onLoading,
          onRefresh: _onRefresh,
          child: Consumer<ProductProv>(
            builder: (context, product, ch) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 24, right: 24, top: 20),
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  _authData.username != null
                                      ? "Your home ${_authData.username}"
                                      : "Send to your home",
                                  style: AppModule.regularText,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.pin_drop,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 38,
                                width: 38,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.grey[400],
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.notifications,
                                    size: 20,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      transitionDuration:
                                          Duration(milliseconds: 500),
                                      transitionsBuilder: (context, animation,
                                          animationTime, child) {
                                        animation = CurvedAnimation(
                                            parent: animation,
                                            curve: Curves.easeIn);
                                        return ScaleTransition(
                                          alignment: Alignment.center,
                                          scale: animation,
                                          child: child,
                                        );
                                      },
                                      pageBuilder:
                                          (context, animation, animationTime) =>
                                              CartPage(),
                                    ),
                                  );
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 38,
                                      width: 38,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.grey[400],
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.shopping_cart_rounded,
                                        size: 20,
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: Consumer<CartProvider>(
                                        builder: (context, cart, ch) =>
                                            cart.totalCart != "0"
                                                ? Container(
                                                    height: 14,
                                                    width: 14,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.deepOrange,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        cart.totalCart,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: AppModule
                                                            .smallText
                                                            .copyWith(
                                                          fontSize: 9,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : SizedBox(),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 24, right: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Consumer<AuthData>(
                          builder: (context, aData, ch) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  Icon(Icons.monetization_on_rounded,
                                      size: 12, color: Colors.grey),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      print("Saldo Tapped");
                                      aData.userClaimed
                                          ? AppModule.showConfirmation(context,
                                              title: "Informasi",
                                              content:
                                                  "Saldo kamu sudah diambil",
                                              cancelText: "",
                                              confirmText: "Oke",
                                              onPressed: () {
                                              Navigator.pop(context);
                                            })
                                          : AppModule.showConfirmation(context,
                                              title: "Hadiah Pengguna baru!",
                                              content:
                                                  "Kamu dapat saldo Rp.500.000.00, ambil sekarang juga!",
                                              cancelText: "Tidak Mau",
                                              confirmText: "Ambil Saldo",
                                              onPressed: () {
                                              _authData.saveSaldo(context);
                                              Navigator.pop(context);
                                            });
                                    },
                                    child: Text(
                                      "Saldo Kamu :",
                                      style: AppModule.smallText.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ]),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  aData.userSaldo == 0
                                      ? "Rp. 0"
                                      : "Rp. ${AppModule.currency.format(aData.userSaldo)},00",
                                  style: AppModule.regularText
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ]),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.shopping_bag_rounded,
                                    size: 12, color: Colors.grey),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Kupon Kamu :",
                                  style: AppModule.smallText.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              "34 Kupon",
                              style: AppModule.regularText
                                  .copyWith(fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  product.loadingCategory
                      ? Center(
                          child: SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : _categorySection(product, _product),
                  SizedBox(
                    height: product.loadingProduct ? 200 : 26,
                  ),
                  product.loadingProduct
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Expanded(
                          child: product.filter
                              ? product.listCategory[product.index ?? 0].product
                                          .length ==
                                      0
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                              Icons
                                                  .sentiment_dissatisfied_sharp,
                                              size: 90,
                                              color: Colors.grey[300]),
                                          SizedBox(height: 10),
                                          Text("Mohon Maaf, Barang Kosong",
                                              style: AppModule.mediumText),
                                        ],
                                      ),
                                    )
                                  : _presentCategoryProduct(product)
                              : ProductCard(product: product),
                        ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  _presentCategoryProduct(ProductProv product) {
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(top: 8, bottom: 20, left: 24, right: 24),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 28,
        crossAxisSpacing: 27,
        childAspectRatio: .72,
      ),
      itemCount: product.listCategory[product.index].product.length,
      itemBuilder: (context, i) {
        final val = product.listCategory[product.index].product[i];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailPage(
                  product: val,
                ),
              ),
            );
          },
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Hero(
                    tag: val.id,
                    child: CachedNetworkImage(
                      fadeInDuration: Duration.zero,
                      fadeOutDuration: Duration.zero,
                      key: UniqueKey(),
                      cacheManager: AppModule.cacheManager,
                      imageUrl: AppModule.ImagePathURL + "/" + val.image,
                      fit: BoxFit.cover,
                      height: 100,
                      width: double.infinity,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[200],
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[100],
                        child: Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    val.productName,
                    style: AppModule.mediumText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "Stok : ${val.qty}",
                  style: AppModule.smallText,
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  "Rp.${AppModule.currency.format(val.price)}",
                  style:
                      AppModule.mediumText.copyWith(color: Colors.deepOrange),
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      Icon(Icons.location_on_outlined,
                          size: 12, color: Colors.grey),
                      Text("Kota Semarang",
                          style:
                              AppModule.smallText.copyWith(color: Colors.grey)),
                    ]),
                    InkWell(
                      onTap: () {
                        print("Favorite Tapped");
                        Provider.of<Favorite>(context, listen: false)
                            .favouriteTapped(
                          context,
                          val.id,
                        );
                      },
                      child: Icon(
                        Icons.favorite_border_sharp,
                        size: 20,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _categorySection(ProductProv product, ProductProv _product) {
    return Container(
      height: 40,
      margin: EdgeInsets.only(left: 24),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: product.listCategory.length ?? 0,
        itemBuilder: (context, i) => InkWell(
          onTap: () {
            _product.filterTapped(i);
            print("Filter Tapped");
          },
          child: product.filter
              ? product.index == i
                  ? Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(right: 24),
                      decoration: BoxDecoration(
                        color: Colors.deepOrange[400],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          product.listCategory[i].categoryName,
                          style: AppModule.smallText.copyWith(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(right: 24),
                      child: Center(
                        child: Text(
                          product.listCategory[i].categoryName,
                          style: AppModule.smallText
                              .copyWith(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    )
              : Container(
                  margin: EdgeInsets.only(right: 24),
                  child: Center(
                    child: Text(
                      product.listCategory[i].categoryName,
                      style: AppModule.smallText
                          .copyWith(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
