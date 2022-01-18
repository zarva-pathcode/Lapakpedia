import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/provider/auth_data.dart';
import 'package:flutter_app/app/ui/screens/login_screen.dart';
import 'package:flutter_app/app/ui/screens/user_page/profile_screen.dart';
import 'package:provider/provider.dart';

class UserSection extends StatefulWidget {
  @override
  _UserSectionState createState() => _UserSectionState();
}

class _UserSectionState extends State<UserSection> {
  @override
  void initState() {
    super.initState();
    authCheck();
  }

  authCheck() async {
    var _auth = Provider.of<AuthData>(context, listen: false);
    await _auth.getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthData>(builder: (context, data, ch) {
      print("Level : ${data.level}");
      if (data.level != 1) {
        return LoginScreen();
      } else {
        return ProfileScreen();
      }
    });
  }
}
