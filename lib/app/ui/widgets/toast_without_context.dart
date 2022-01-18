import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NoContextToast extends StatefulWidget {
  @override
  _NoContextToastState createState() => _NoContextToastState();
}

class _NoContextToastState extends State<NoContextToast> {
  final toast = FToast();

  @override
  void initState() {
    super.initState();
    toast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: showBottomToast(),
    );
  }

  showBottomToast() =>
      toast.showToast(child: buildToast(), gravity: ToastGravity.BOTTOM);

  Widget buildToast() => Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.green[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check,
              color: Colors.black,
              size: 24,
            ),
            SizedBox(
              width: 10,
            ),
            Text("Showing custom Toast here"),
          ],
        ),
      );
}
