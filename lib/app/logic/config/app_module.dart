import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AppModule {
  static FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  static const String BaseURL = "http://firsttouch.my.id/ecommerce/api";
  static const String ImagePathURL = "http://firsttouch.my.id/ecommerce/upload";
  static final toast = FToast();
  static final cacheManager = CacheManager(Config(
    'cacheKey',
    stalePeriod: const Duration(days: 1),
    maxNrOfCacheObjects: 50,
  ));
  static final currency = NumberFormat("#,##0", "en_US");
  static final money =
      NumberFormat.currency(customPattern: "\u00a4 #,##.#", locale: "en_US");
  static const Color scafBackgroundColor = Colors.white;
  static const Color darkBackgrounfColor = Colors.black;

  //TEXT STYLE
  static TextStyle headerText = GoogleFonts.montserrat(
      color: Colors.black, fontSize: 22, letterSpacing: -.9);
  static TextStyle largeText = GoogleFonts.montserrat(
      color: Colors.black, fontSize: 18, letterSpacing: -.7);
  static TextStyle mediumText = GoogleFonts.montserrat(
      color: Colors.black, fontSize: 16, letterSpacing: -.65);
  static TextStyle regularText = GoogleFonts.montserrat(
      color: Colors.black, fontSize: 14, letterSpacing: -.6);
  static TextStyle smallText = GoogleFonts.montserrat(
      color: Colors.black, fontSize: 10, letterSpacing: -.5);
  static TextStyle buttonText = GoogleFonts.montserrat(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    letterSpacing: -.6,
  );
  static TextStyle formText = GoogleFonts.montserrat(
      color: Colors.black, fontSize: 13, letterSpacing: -.6);

  //CUSTOM FUNCTION -->
  static showInfo({String msg, Color color}) {
    return Fluttertoast.showToast(
      msg: msg,
      fontSize: 14,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: color,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
    );
  }

//{String msg, Color backColor, IconData icon}
  static contextToast({
    String msg,
    Color backColor,
    bool isBottom = true,
    bool shortTime = true,
    bool isSuccess = true,
  }) {
    return toast.showToast(
        toastDuration: shortTime
            ? Duration(milliseconds: 900)
            : Duration(milliseconds: 3500),
        gravity: isBottom ? ToastGravity.BOTTOM : ToastGravity.TOP,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
          decoration: BoxDecoration(
            color: isSuccess ? Colors.green : Colors.red[400],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FaIcon(
                isSuccess
                    ? FontAwesomeIcons.solidCheckCircle
                    : FontAwesomeIcons.exclamationCircle,
                color: Colors.white,
                size: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                msg == null ? "Testing, Text masih null" : msg,
                style: regularText.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ));
  }

  static showConfirmation(BuildContext context,
      {String title,
      String content,
      String confirmText,
      String cancelText,
      Function onPressed}) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        titleTextStyle: largeText,
        contentTextStyle: mediumText,
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              cancelText,
              style: regularText.copyWith(
                  color: Colors.red[700], fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(
              confirmText,
              style: regularText.copyWith(
                  color: Colors.blue[700], fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  static snackBarInfo(
    BuildContext context, {
    String msg,
    String order,
    Color backColor,
    Function onPressed,
  }) =>
      Scaffold.of(context).showSnackBar(
        SnackBar(
          backgroundColor: backColor,
          content: Text(
            msg,
            style: AppModule.mediumText.copyWith(color: Colors.white),
          ),
          action: SnackBarAction(
            label: order,
            onPressed: onPressed,
            textColor: Colors.white,
          ),
        ),
      );

  static loadingDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        titleTextStyle: largeText,
        contentTextStyle: mediumText,
        title: CircularProgressIndicator(),
        content: Text("Loading.. please wait."),
      ),
    );
  }

  static generateToken(String token) async {
    final _fcmToken = await _firebaseMessaging.getToken();
    token = _fcmToken;
    print("FCM Token : $token");
  }

  static void actionSnackbar(
    BuildContext context, {
    String msg,
    String label,
    Function onTap,
    IconData icon,
    Color backColor,
  }) {
    final snackbar = SnackBar(
      padding: EdgeInsets.only(left: 16, top: 0, bottom: 0, right: 12),
      duration: Duration(minutes: 1),
      backgroundColor: backColor,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FaIcon(
                icon,
                color: Colors.white,
                size: 12,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                msg,
                style: AppModule.regularText.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          OutlinedButton(
            onPressed: onTap,
            style: OutlinedButton.styleFrom(
              minimumSize: Size(10, 30),
              side: BorderSide(
                color: Colors.white,
              ),
            ),
            child: Text(
              label,
              style: AppModule.smallText
                  .copyWith(color: Colors.white, fontSize: 12),
            ),
          )
        ],
      ),
    );

    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackbar);
  }
  //-->
}
