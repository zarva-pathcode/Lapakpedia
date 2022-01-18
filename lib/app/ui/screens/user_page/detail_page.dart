import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/config/app_module.dart';
import 'package:flutter_app/app/logic/models/product.dart';
import 'package:flutter_app/app/logic/provider/cart_provider.dart';
import 'package:flutter_app/app/logic/provider/favorite_provider.dart';
import 'package:flutter_app/app/ui/widgets/user_widget.dart/app_appbar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  final currency = NumberFormat("#,##0", "en_US");
  final Product product;

  DetailPage({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext mainContext) {
    var _cart = Provider.of<CartProvider>(mainContext, listen: false);
    var _favC = Provider.of<Favorite>(mainContext, listen: false);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 24,
              left: 22,
              right: 22,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyAppBar(
                  header: "Detail Page",
                  actions: InkWell(
                    onTap: () {
                      _favC.favouriteTapped(
                        mainContext,
                        product.id,
                      );
                    },
                    child: Icon(Icons.favorite_outline),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Hero(
                    tag: product.id,
                    child: CachedNetworkImage(
                      fadeInDuration: Duration(milliseconds: 100),
                      fadeOutDuration: Duration(milliseconds: 100),
                      key: UniqueKey(),
                      cacheManager: AppModule.cacheManager,
                      imageUrl: AppModule.ImagePathURL + "/" + product.image,
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
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
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(mainContext).size.width / 1.7,
                      height: 46,
                      child: Text(
                        product.productName,
                        style: AppModule.largeText,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Text(
                      "Rp. ${currency.format(product.price)}",
                      style: AppModule.largeText
                          .copyWith(color: Colors.deepOrange),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Text("Stok ${product.qty}", style: AppModule.regularText),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Kota Semarang",
                      style: AppModule.regularText.copyWith(
                        color: Colors.grey[400],
                      ),
                    ),
                    Icon(
                      Icons.location_on,
                      size: 18,
                      color: Colors.grey[400],
                    )
                  ],
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Deskripsi Produk",
                  style: AppModule.mediumText,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  product.desc,
                  style:
                      AppModule.regularText.copyWith(color: Colors.grey[400]),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 54,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  print("first tapped");
                },
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "Beli Langsung",
                      style: AppModule.regularText.copyWith(
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  _cart.addTmpItemCart(mainContext, product.id);
                  print("second tapped");
                },
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.orange,
                  child: Center(
                    child: Text(
                      "Masukan Keranjang",
                      style: AppModule.regularText.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
