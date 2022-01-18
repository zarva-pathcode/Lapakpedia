import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/config/app_module.dart';
import 'package:flutter_app/app/logic/provider/favorite_provider.dart';
import 'package:flutter_app/app/ui/screens/user_page/detail_page.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WishlistPage extends StatelessWidget {
  final currency = NumberFormat("#,##0", "en_US");
  WishlistPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _favorite = Provider.of<Favorite>(context, listen: false);
    final RefreshController _refreshController =
        RefreshController(initialRefresh: true);
    void _onRefresh() async {
      _favorite.getUserFavourite(context);
      _refreshController.refreshCompleted();
      AppModule.toast.init(context);
    }

    void _onLoading() async {
      await Future.delayed(Duration(milliseconds: 1000));
      _refreshController.loadComplete();
    }

    return Scaffold(
      body: SmartRefresher(
        controller: _refreshController,
        onLoading: _onLoading,
        onRefresh: _onRefresh,
        child: SafeArea(
          child: Consumer<Favorite>(builder: (context, data, ch) {
            return ListView(
              children: [
                SizedBox(height: 30),
                Center(
                  child: Text(
                    "Wishlist Kamu",
                    style: AppModule.largeText,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: data.loading ? 300 : 30,
                ),
                data.loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : data.isNull
                        ? Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 240,
                                ),
                                Icon(
                                  Icons.emoji_emotions_rounded,
                                  color: Colors.grey[300],
                                  size: 80,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Wishlist Kamu Kosong nih",
                                  style: AppModule.regularText.copyWith(
                                      color: Colors.grey[300],
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          )
                        : SizedBox(
                            width: double.infinity,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: data.productlist.length,
                              itemBuilder: (context, i) {
                                final val = data.productlist[i];
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
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 24),
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.grey[200],
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: Hero(
                                                tag: val.id,
                                                child: CachedNetworkImage(
                                                  fadeInDuration: Duration.zero,
                                                  fadeOutDuration:
                                                      Duration.zero,
                                                  key: UniqueKey(),
                                                  cacheManager:
                                                      AppModule.cacheManager,
                                                  imageUrl:
                                                      AppModule.ImagePathURL +
                                                          "/" +
                                                          val.image,
                                                  fit: BoxFit.cover,
                                                  height: 65,
                                                  width: 80,
                                                  placeholder: (context, url) =>
                                                      Container(
                                                    color: Colors.grey[200],
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Container(
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
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  val.productName,
                                                  style: AppModule.regularText,
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  "Stok : ${val.qty}",
                                                  style: AppModule.smallText,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Rp.${AppModule.currency.format(val.price)}",
                                                  style: AppModule.mediumText
                                                      .copyWith(
                                                    color: Colors.deepOrange,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                _favorite.favouriteTapped(
                                                  context,
                                                  val.id,
                                                );
                                              },
                                              child: Icon(
                                                Icons.favorite_outline_rounded,
                                                size: 22,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
              ],
            );
          }),
        ),
      ),
    );
  }
}
