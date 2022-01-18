import 'package:flutter/material.dart';

class CardPayment extends StatefulWidget {
  @override
  _CardPaymentState createState() => _CardPaymentState();
}

class _CardPaymentState extends State<CardPayment> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        child: ListView.builder(
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text("Visa"),
            );
          },
        ),
      ),
    );
  }
}
