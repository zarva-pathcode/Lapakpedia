import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/config/app_module.dart';

class LoadingScreen extends StatelessWidget {
  final bool status;

  const LoadingScreen({Key key, this.status = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return status == true
        ? Container(
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width / 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Menambahkan...",
                  style: AppModule.mediumText,
                ),
              ],
            ),
          )
        : SizedBox.shrink();
  }
}
