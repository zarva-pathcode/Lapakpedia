import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/config/app_module.dart';
import 'package:flutter_app/app/logic/models/history.dart';

class HistoryDetailPage extends StatefulWidget {
  final History history;

  const HistoryDetailPage({Key key, this.history}) : super(key: key);

  @override
  State<HistoryDetailPage> createState() => _HistoryDetailPageState();
}

class _HistoryDetailPageState extends State<HistoryDetailPage> {
  @override
  Widget build(BuildContext context) {
    var total;
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.all(24),
          children: [
            Row(
              children: [
                Text(
                  "Flu",
                  style: AppModule.largeText.copyWith(
                      color: Colors.deepOrange, fontWeight: FontWeight.bold),
                ),
                Text(
                  "commerce",
                  style: AppModule.largeText.copyWith(
                      color: Colors.indigo, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 26,
            ),
            Text(
              "Nomor Invoice : ${widget.history.noInvoice}",
              style: AppModule.regularText,
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              "Tanggal & Waktu : ${widget.history.createdDate}",
              style: AppModule.regularText,
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  "Keterangan : ",
                  style: AppModule.regularText,
                ),
                Text(
                  widget.history.status == "0" ? "Belum Dibayar" : "Lunas",
                  style: AppModule.regularText.copyWith(
                    color: widget.history.status == "0"
                        ? Colors.red
                        : Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(
              width: double.infinity,
              child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: widget.history.detail.length,
                itemBuilder: (context, i) {
                  final val = widget.history.detail[i];
                  var total = val.qty * val.price;
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey[200],
                        ),
                      ),
                    ),
                    child: Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
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
                                    imageUrl: AppModule.ImagePathURL +
                                        "/" +
                                        val.image,
                                    fit: BoxFit.cover,
                                    height: 40,
                                    width: 60,
                                    placeholder: (context, url) => Container(
                                      color: Colors.grey[200],
                                    ),
                                    errorWidget: (context, url, error) =>
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    val.productName,
                                    style: AppModule.regularText,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Jumlah yang dibeli : ${val.qty}",
                                    style: AppModule.smallText,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Rp.${AppModule.currency.format(val.price)}",
                                    style: AppModule.regularText.copyWith(
                                      color: Colors.deepOrange[400],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total :",
                                style: AppModule.smallText,
                              ),
                              Text(
                                "Rp. ${AppModule.currency.format(total)}",
                                style: AppModule.regularText
                                    .copyWith(color: Colors.deepOrange[400]),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
