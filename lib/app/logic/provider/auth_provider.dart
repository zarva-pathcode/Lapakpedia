import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/config/app_module.dart';
import 'package:flutter_app/app/logic/provider/auth_data.dart';
import 'package:flutter_app/app/logic/repository/auth_repo.dart';
import 'package:flutter_app/app/ui/screens/register_screen.dart';
import 'package:flutter_app/app/ui/screens/user_page/navigator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String _fcmToken;
  // FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount _googleUser;
  GoogleSignInAuthentication _googleAuth;
  AuthCredential _credential;
  var email = "";
  var password = "";
  var _message = "";
  var username = "";
  var phone = "";
  var createdDate = "";
  var _token = "";
  int _value, _level, _id;

  Future<void> googleLogin(BuildContext context) async {
    await generateToken();
    _googleUser = await _googleSignIn.signIn();
    _googleAuth = await _googleUser.authentication;
    _credential = GoogleAuthProvider.credential(
      accessToken: _googleAuth.accessToken,
      idToken: _googleAuth.idToken,
    );
    final _user =
        (await FirebaseAuth.instance.signInWithCredential(_credential)).user;
    if (_user != null) {
      email = _user.providerData[0].email;
      print("Email : $email");
      print("Token : $_token");
      checkEmail(context, email);
    }

    notifyListeners();
  }

  checkEmail(BuildContext context, String email) async {
    final data = await AuthRepo.loginGoogle(
      email,
      _token,
    );
    print("Data Response : $data");
    _value = data["value"];
    _message = data["message"];

    if (_value == 1) {
      print("Data User : $data");
      _id = int.parse(data["id"]);
      username = data["fullname"];
      phone = data["phone"];
      _level = int.parse(data["level"]);
      createdDate = data["createdDate"];
      await Provider.of<AuthData>(context, listen: false).savePref(
        id: _id,
        email: email,
        username: username,
        level: _level,
        phone: phone,
        createdDate: createdDate,
      );
      AppModule.contextToast(
          msg: "$_message $username!", shortTime: false, isBottom: false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => NavigationSection(),
        ),
      );
    } else {
      print("Data User : $data");
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 600),
          transitionsBuilder: (context, animation, animationTime, child) {
            animation =
                CurvedAnimation(parent: animation, curve: Curves.easeIn);
            return SlideTransition(
              position: Tween<Offset>(begin: Offset(1, 0), end: Offset.zero)
                  .animate(animation),
              child: child,
            );
          },
          pageBuilder: (context, animation, animationTime) => RegisterScreen(),
        ),
      );
    }
  }

  register(BuildContext context) async {
    await generateToken();
    final data =
        await AuthRepo.userReg(email, password, username, phone, _token);
    print("Data Response : $data");
    _value = data["value"];
    _message = data["message"];
    if (_value == 1) {
      _id = int.parse(data["id"]);
      username = data["fullname"];
      phone = data["phone"];
      _level = int.parse(data["level"]);
      createdDate = data["createdDate"];
      print("Data User : $data");
      await Provider.of<AuthData>(context, listen: false).savePref(
        id: _id,
        email: email,
        username: username,
        level: _level,
        phone: phone,
        createdDate: createdDate,
      );
      AppModule.contextToast(
          msg: "$_message $username!", shortTime: false, isBottom: false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => NavigationSection(),
        ),
      );
    } else {
      print("Data User : $data");
      AppModule.showInfo(msg: _message, color: Colors.red[600]);
    }
    notifyListeners();
  }

  generateToken() async {
    _fcmToken = await _firebaseMessaging.getToken();
    _token = _fcmToken;
    print("FCM Token : $_fcmToken");
    notifyListeners();
  }

  Future logout(BuildContext context) async {
    await _googleSignIn.signOut().then((_) {
      Provider.of<AuthData>(context, listen: false).deletePref();
      FirebaseAuth.instance.signOut();
    });
    email = null;
    _token = null;
    notifyListeners();
  }

  setUp() async {
    _googleUser = null;
    email = null;
    _token = null;
    await generateToken();
    notifyListeners();
  }

  manualLogin(BuildContext context) async {
    if (email.length == 0 || password.length == 0) {
      return AppModule.actionSnackbar(context,
          icon: FontAwesomeIcons.exclamation,
          msg: "Pastikan semua form terisi",
          backColor: Colors.red,
          label: "Oke", onTap: () {
        Scaffold.of(context).hideCurrentSnackBar();
      });
    } else {
      if (!email.contains("@")) {
        return AppModule.actionSnackbar(context,
            icon: FontAwesomeIcons.exclamation,
            msg: "Isi email dengan benar",
            backColor: Colors.red,
            label: "Oke", onTap: () {
          Scaffold.of(context).hideCurrentSnackBar();
        });
      } else if (!password.contains(RegExp(r'[0-9]'))) {
        return AppModule.actionSnackbar(context,
            icon: FontAwesomeIcons.exclamation,
            msg: "Password harus mengandung angka",
            backColor: Colors.red,
            label: "Oke", onTap: () {
          Scaffold.of(context).hideCurrentSnackBar();
        });
      } else if (password.length < 8) {
        return AppModule.actionSnackbar(context,
            icon: FontAwesomeIcons.exclamation,
            msg: "Password 8 karakter atau lebih",
            backColor: Colors.red,
            label: "Oke", onTap: () {
          Scaffold.of(context).hideCurrentSnackBar();
        });
      } else {
        await generateToken();
        final data = await AuthRepo.loginPassword(
          email,
          password,
          _token,
        );
        print("Data Response : $data");
        _value = data["value"];
        _message = data["message"];

        if (_value == 1) {
          _id = int.parse(data["id"]);
          username = data["fullname"];
          phone = data["phone"];
          _level = int.parse(data["level"]);
          createdDate = data["createdDate"];
          print("Data User : $data");
          await Provider.of<AuthData>(context, listen: false).savePref(
            id: _id,
            email: email,
            username: username,
            level: _level,
            phone: phone,
            createdDate: createdDate,
          );
          AppModule.contextToast(
              msg: "$_message $username!", shortTime: false, isBottom: false);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => NavigationSection(),
            ),
          );
        } else {
          AppModule.actionSnackbar(context,
              backColor: Colors.red,
              icon: FontAwesomeIcons.exclamation,
              msg: _message,
              label: "Oke", onTap: () {
            Scaffold.of(context).hideCurrentSnackBar();
          });
        }
      }
    }
    notifyListeners();
  }
}
