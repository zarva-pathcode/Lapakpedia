import 'package:flutter/material.dart';
import 'package:flutter_app/app/routes/routes_name.dart';
import 'package:flutter_app/app/ui/helper/app_style.dart';
import 'package:flutter_app/app/ui/screens/admin_page/add_product_screen.dart';
import 'package:flutter_app/app/ui/screens/admin_page/admin_screen.dart';
import 'package:flutter_app/app/ui/widgets/error_screen.dart';
import 'package:flutter_app/app/ui/screens/user_page/user_home_screen.dart';
import 'package:flutter_app/app/ui/widgets/loading_widget.dart';
import 'package:flutter_app/app/ui/screens/login_screen.dart';
import 'package:flutter_app/app/ui/screens/user_page/profile_data_screen.dart';
import 'package:flutter_app/app/ui/screens/user_page/profile_screen.dart';
import 'package:flutter_app/app/ui/screens/register_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => UserHomeScreen());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case registerRoute:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case errorRoute:
        return MaterialPageRoute(builder: (_) => ErrorScreen());
      case loadingRoute:
        return MaterialPageRoute(builder: (_) => LoadingScreen());
      case profileRoute:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case addProduct:
        return MaterialPageRoute(builder: (_) => AddProductScreen());
      case profileData:
        return MaterialPageRoute(builder: (_) => ProfileDataScreen());
      case adminRoute:
        return MaterialPageRoute(builder: (_) => AdminScreen());
      // case editProduct:
      //   return MaterialPageRoute(
      //       builder: (context) =>
      //           EditProductScreen(ModalRoute.of(context).settings.arguments));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text(
                    'No route defined for ${settings.name}',
                    style: AppStyle.largeText,
                  )),
                ));
    }
  }
}
