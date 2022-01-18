import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/provider/auth_data.dart';
import 'package:flutter_app/app/ui/screens/admin_page/admin_screen.dart';
import 'package:flutter_app/app/ui/screens/user_page/navigator.dart';
import 'package:flutter_app/app/ui/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

class AuthSection extends StatefulWidget {
  @override
  _AuthSectionState createState() => _AuthSectionState();
}

class _AuthSectionState extends State<AuthSection> {
  @override
  void initState() {
    super.initState();
    authCheck();
    print("InitState");
  }

  authCheck() async {
    var _auth = Provider.of<AuthData>(context, listen: false);
    await _auth.getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthData>(builder: (context, data, ch) {
      print("Level : ${data.level}");
      if (data.level == 2) {
        return AdminScreen();
      } else if (data.level == 1 || data.level == 0) {
        return NavigationSection();
      } else {
        return LoadingScreen();
      }
    });
  }
}
