import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/config/app_module.dart';
import 'package:flutter_app/app/logic/provider/auth_data.dart';
import 'package:flutter_app/app/logic/repository/auth_repo.dart';
import 'package:flutter_app/app/ui/screens/login_screen.dart';
import 'package:provider/provider.dart';

import 'package:device_info/device_info.dart';

class Authentication with ChangeNotifier {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String email = "";
  String username = "";
  String password = "";
  String confirmPass = "";
  String _deviceId;
  String get deviceId => _deviceId;
  int id;
  int value;
  int level;

  login(BuildContext context) async {
    if (email.length == 0 || password.length == 0) {
      return AppModule.showInfo(
        msg: "Pastikan Anda mengisi semua Form",
        color: Colors.red[600],
      );
    }
    // var resp = await UserRepo.loginUser(email);

    // value = resp["value"];
    // level = int.parse(resp["level"]);
    // username = resp["name"];
    // id = int.parse(resp['id']);
    print("Your Id: $id");
    print("Your Level: $level");
    print("Your value: $value");
    if (value == 1) {
      await Provider.of<AuthData>(context, listen: false)
          .savePref(email: email, username: username, level: level, id: id)
          .then((_) async {
        AppModule.showInfo(
          msg: "Berhasil, Selamat Datang",
          color: Colors.green[600],
        );
      });
    } else {
      AppModule.showInfo(
        msg: "Gagal, akun tidak terdaftar",
        color: Colors.red[600],
      );
    }
    notifyListeners();
  }

  register(BuildContext context) async {
    if (email.length == 0 ||
        password.length == 0 ||
        confirmPass.length != password.length) {
      return AppModule.showInfo(
        msg: "Pastikan Anda mengisi semua Form Dengan Benar",
        color: Colors.red[600],
      );
    }
    var resp =
        await AuthRepo.userReg(email, password, password, password, password);
    value = resp["value"];
    if (value == 1) {
      Navigator.pop(context);
      AppModule.showInfo(
        msg: "Berhasil membuat akun baru",
        color: Colors.green[600],
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (c) => LoginScreen(),
        ),
      );
    } else if (value == 2) {
      AppModule.showInfo(
        msg: "Gagal, Akun sudah terdaftar",
        color: Colors.red[600],
      );
    } else {
      AppModule.showInfo(
        msg: "Pembuatan akun gagal",
        color: Colors.red[600],
      );
    }
    notifyListeners();
  }

  logout(BuildContext context) {
    return AppModule.showConfirmation(
      context,
      title: "Attention",
      content: "Are you sure want to log out?",
      confirmText: "Sure",
      cancelText: "Cancel",
      onPressed: () async {
        await Provider.of<AuthData>(context, listen: false).deletePref().then(
          (_) {
            AppModule.showInfo(
              msg: "Log out Berhasil",
              color: Colors.green[600],
            );
          },
        );
        notifyListeners();
      },
    );
  }

  getDeviceInfo() async {
    final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    _deviceId = androidInfo.androidId;
    print("Device Info dari Authentication: $_deviceId");
    notifyListeners();
  }
}
