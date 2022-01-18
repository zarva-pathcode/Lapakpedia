import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/config/app_module.dart';

class MyAppBar extends StatelessWidget {
  final String header;
  final Widget actions;

  const MyAppBar({Key key, this.header, this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: actions != null
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 40,
              width: 40,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey[400],
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 16,
                  ),
                  SizedBox(
                    width: 1,
                  )
                ],
              ),
            )),
        actions != null
            ? SizedBox()
            : SizedBox(
                width: MediaQuery.of(context).size.width / 7,
              ),
        Text(
          header,
          style: AppModule.largeText,
        ),
        actions != null
            ? SizedBox(
                width: MediaQuery.of(context).size.width / 340,
              )
            : SizedBox(),
        actions != null ? actions : SizedBox.shrink(),
      ],
    );
  }
}
