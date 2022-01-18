import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/config/app_module.dart';
import 'package:flutter_app/app/logic/provider/history_provider.dart';
import 'package:flutter_app/app/ui/screens/user_page/history_detail.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RefreshController _refreshController =
        RefreshController(initialRefresh: true);
    void _onRefresh() async {
      AppModule.toast.init(context);
      Provider.of<HistoryProvider>(context, listen: false).getHistory(context);
      _refreshController.refreshCompleted();
    }

    void _onLoading() async {
      await Future.delayed(Duration(milliseconds: 1000));
      _refreshController.loadComplete();
    }

    return Container(
      child: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            Consumer<HistoryProvider>(
              builder: (context, data, ch) {
                return data.list.length == 0
                    ? Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 250,
                            ),
                            FaIcon(
                              FontAwesomeIcons.smile,
                              size: 40,
                              color: Colors.grey[400],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Yuk lakukan Transaksi!",
                              style: AppModule.mediumText
                                  .copyWith(color: Colors.grey[400]),
                            )
                          ],
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.list.length,
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        itemBuilder: (context, i) {
                          var x = data.list[i];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => HistoryDetailPage(
                                            history: x,
                                          )));
                            },
                            child: Container(
                              padding: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey[300],
                                  ),
                                ),
                              ),
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: FaIcon(
                                  x.status == "0"
                                      ? Icons.pending_actions_rounded
                                      : FontAwesomeIcons.checkDouble,
                                  color: x.status == "0"
                                      ? Colors.red[600]
                                      : Colors.green[600],
                                ),
                                title: Text(
                                  "No. ${x.noInvoice}",
                                  style: AppModule.mediumText,
                                ),
                                subtitle: Text(
                                  x.status == "0" ? "Belum Dibayar" : "Lunas",
                                  style: AppModule.mediumText.copyWith(
                                    color: x.status == "0"
                                        ? Colors.red[600]
                                        : Colors.green[600],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
              },
            )
          ],
        ),
      ),
    );
  }
}
