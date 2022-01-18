import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/config/app_module.dart';
import 'package:flutter_app/app/logic/provider/favorite_provider.dart';
import 'package:flutter_app/app/logic/provider/product_provider.dart';
import 'package:flutter_app/app/ui/screens/user_page/detail_page.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final ProductProv product;
  final Function onFavourite;
  final bool isWishlist;
  const ProductCard(
      {Key key, this.product, this.onFavourite, this.isWishlist = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.only(top: 8, bottom: 20, left: 24, right: 24),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 28,
          crossAxisSpacing: 27,
          childAspectRatio: .72,
        ),
        physics: BouncingScrollPhysics(),
        itemCount: product.listProduct.length,
        itemBuilder: (context, i) {
          var val = product.listProduct[i];
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
                  Text("Stok : ${val.qty}", style: AppModule.smallText),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(children: [
                        Icon(Icons.location_on_outlined,
                            size: 12, color: Colors.grey),
                        Text(
                          "Kota Semarang",
                          style:
                              AppModule.smallText.copyWith(color: Colors.grey),
                        ),
                      ]),
                      InkWell(
                        onTap: () {
                          print("Favourite Tapped");
                          Provider.of<Favorite>(context, listen: false)
                              .favouriteTapped(context, val.id);
                        },
                        child: isWishlist
                            ? Icon(Icons.add_shopping_cart_rounded)
                            : Icon(
                                Icons.favorite_border_sharp,
                                size: 20,
                              ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
