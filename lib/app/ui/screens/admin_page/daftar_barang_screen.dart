import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/config/app_module.dart';
import 'package:flutter_app/app/logic/provider/product_provider.dart';
import 'package:flutter_app/app/ui/screens/admin_page/edit_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DaftarBarang extends StatelessWidget {
  final currency = NumberFormat("#,##0", "en_US");
  @override
  Widget build(BuildContext context) {
    var _product = Provider.of<ProductProv>(context, listen: false);
    final RefreshController _refreshController =
        RefreshController(initialRefresh: true);
    void _onRefresh() async {
      _product.getProduct(context);
      _refreshController.refreshCompleted();
    }

    void _onLoading() async {
      await Future.delayed(Duration(milliseconds: 1000));
      _refreshController.loadComplete();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[400],
        title: Text(
          "Daftar Barang",
          style: AppModule.largeText.copyWith(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Consumer<ProductProv>(
        builder: (context, data, ch) => SmartRefresher(
          physics: BouncingScrollPhysics(),
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          controller: _refreshController,
          child: data.loadingProduct
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: data.listProduct.length,
                  itemBuilder: (context, i) => Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditProductScreen(
                              data.listProduct[i],
                            ),
                          ),
                        );
                      },
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: CachedNetworkImage(
                          fadeInDuration: Duration.zero,
                          fadeOutDuration: Duration.zero,
                          key: UniqueKey(),
                          cacheManager: AppModule.cacheManager,
                          imageUrl: AppModule.ImagePathURL +
                              "/" +
                              data.listProduct[i].image,
                          fit: BoxFit.cover,
                          height: 65,
                          width: 80,
                          placeholder: (context, url) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.grey[200],
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[100],
                            ),
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        data.listProduct[i].productName,
                        style: AppModule.regularText,
                      ),
                      subtitle: Text(
                          "Rp.${currency.format(data.listProduct[i].price)}"),
                      trailing: IconButton(
                        onPressed: () {
                          _product.deleteProduct(
                              context, data.listProduct[i].id);
                        },
                        icon: Icon(Icons.delete_forever_rounded),
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
