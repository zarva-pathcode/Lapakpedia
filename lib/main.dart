import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/app/logic/provider/auth_provider.dart';
import 'package:flutter_app/app/logic/provider/favorite_provider.dart';
import 'package:flutter_app/app/logic/provider/history_provider.dart';
import 'package:flutter_app/app/logic/provider/product_provider.dart';
import 'package:flutter_app/app/ui/screens/user_section.dart/auth_section.dart';
import 'package:provider/provider.dart';
import 'app/logic/provider/auth_data.dart';
import 'app/logic/provider/cart_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthData(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProv(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Favorite(),
        ),
        ChangeNotifierProvider(
          create: (context) => HistoryProvider(),
        ),
      ],
      builder: (context, widget) => MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, ch) => MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: ch),
        title: 'Flutter App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AuthSection(),
      ),
    );
  }
}
