import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/config/app_module.dart';
import 'package:flutter_app/app/ui/screens/user_page/history_transac.dart';
import 'package:flutter_app/app/ui/screens/user_page/on_going_transac.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransactionPage extends StatefulWidget {
  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage>
    with SingleTickerProviderStateMixin {
  TabController controller;
  void initState() {
    controller = new TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(double.infinity, 70),
            child: Container(
              height: 70,
              color: Colors.indigo,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: TabBar(
                  controller: controller,
                  indicatorColor: Colors.orange[400],
                  indicatorWeight: 3,
                  tabs: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.clock,
                              size: 18,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "On Going",
                              style: AppModule.mediumText
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.history,
                              size: 18,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "History",
                              style: AppModule.mediumText
                                  .copyWith(color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            controller: controller,
            children: [
              OnGoing(),
              History(),
            ],
          )),
    );
  }
}
