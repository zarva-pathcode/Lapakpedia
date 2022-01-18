import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/config/app_module.dart';
import 'package:flutter_app/app/logic/provider/cart_provider.dart';
import 'package:flutter_app/app/logic/provider/product_provider.dart';
import 'package:flutter_app/app/ui/screens/user_page/detail_page.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.clear();
    _controller.dispose();
    super.dispose();
  }

  final currency = NumberFormat("#,##0", "en_US");
  @override
  Widget build(BuildContext context) {
    var _product = Provider.of<ProductProv>(context, listen: false);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Consumer<ProductProv>(
            builder: (context, data, ch) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 65,
                  color: Colors.indigo,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Search",
                          style: AppModule.regularText.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 228,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: TextField(
                            autofocus: true,
                            controller: _controller,
                            onChanged: _product.onSearch,
                            style: AppModule.largeText,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 10),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 34,
                            width: 34,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              Icons.search_rounded,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                data.loadingProduct
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            Text(
                              "Tunggu Sebentar...",
                              style: AppModule.mediumText
                                  .copyWith(color: Colors.grey),
                            )
                          ],
                        ),
                      )
                    : _controller.text.isNotEmpty || data.searchList.length != 0
                        ? Expanded(
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.only(
                                  bottom: 20, left: 16, right: 16),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: .75,
                              ),
                              itemCount: data.searchList.length,
                              itemBuilder: (context, i) {
                                final val = data.searchList[i];
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
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border:
                                            Border.all(color: Colors.grey[300]),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(.2),
                                            blurRadius: 5,
                                          )
                                        ]),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Hero(
                                              tag: val.id,
                                              child: Image.network(
                                                val.image == null
                                                    ? "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.daad.org.cn%2Fwp-content%2Fplugins_old%2Fwp-media-folder%2Fassets%2Fimages%2F&psig=AOvVaw2MQNsjxheCA7Xr9xTfv5M0&ust=1636164829895000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCOiWk5CTgPQCFQAAAAAdAAAAABAJ"
                                                    : "http://firsttouch.my.id/ecommerce/upload/${val.image}",
                                                fit: BoxFit.cover,
                                                height: 100,
                                                width: double.infinity,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            val.productName,
                                            style: AppModule.mediumText,
                                          ),
                                          Text(
                                            "Stok : ${val.qty}",
                                            style:
                                                AppModule.smallText.copyWith(),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Rp.${currency.format(val.price)}",
                                            style: AppModule.mediumText
                                                .copyWith(
                                                    color: Colors.deepOrange),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(children: [
                                                Icon(Icons.location_on_outlined,
                                                    size: 11),
                                                Text("Kota Semarang",
                                                    style: AppModule.smallText),
                                              ]),
                                              InkWell(
                                                onTap: () {
                                                  print("Favorite Tapped");
                                                  // _cart.addItemToCart(
                                                  //   context,
                                                  //   val.id,
                                                  //   val.price,
                                                  // );
                                                },
                                                child: Icon(
                                                  Icons.favorite_border_sharp,
                                                  size: 18,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 250,
                                ),
                                Icon(
                                  Icons.manage_search_rounded,
                                  size: 80,
                                  color: Colors.grey[300],
                                ),
                                Text(
                                  "Cari produk yuk!",
                                  style: AppModule.regularText.copyWith(
                                      color: Colors.grey[300],
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
