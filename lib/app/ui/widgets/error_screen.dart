import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/config/app_module.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(
          Icons.cancel_sharp,
          color: Colors.red,
          size: 120,
        ),
        const SizedBox(
          height: 40,
        ),
        Text(
          "Oppss..., Something went wrong",
          style: AppModule.largeText.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Make sure that you have a good connection",
          style: AppModule.regularText,
        ),
      ])),
    );
  }
}
