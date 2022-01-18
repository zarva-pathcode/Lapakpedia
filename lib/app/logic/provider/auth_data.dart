import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/config/app_module.dart';
import 'package:flutter_app/app/logic/config/prefs_data.dart';
import 'package:flutter_app/app/logic/provider/cart_provider.dart';
import 'package:flutter_app/app/ui/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthData extends ChangeNotifier {
  SharedPreferences _prefs;
  String _email, _username, _phone;
  String get email => _email;
  String get username => _username;
  String get phone => _phone;
  int _value = 0;
  int _level = 0;
  int _id = 0;
  var _saldo = 0;
  int get level => _level ?? 0;
  int get uid => _id ?? 0;

  var _loggedIn = false;
  var _userClaimed = false;
  int get userSaldo => _saldo;
  bool get userClaimed => _userClaimed == true;
  bool get loggedIn => _loggedIn == true;
  bool get isAuth => _value != 0;

  Future<void> _initPrefs() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  Future<void> getPref() async {
    await _initPrefs();

    if (_prefs.getInt(Data.level) == 1 &&
        _prefs.getString(Data.email) != null) {
      print("Hello User");
      _loggedIn = _prefs.getBool(Data.loggedIn);
      _level = _prefs.getInt(Data.level);
      _username = _prefs.getString(Data.fullname);
      _id = _prefs.getInt(Data.id);
    } else if (_prefs.getInt(Data.level) == 2 &&
        _prefs.getString(Data.email) != null) {
      print("Hello Admin");
      _loggedIn = _prefs.getBool(Data.loggedIn);
      _level = _prefs.getInt(Data.level);
      _username = _prefs.getString(Data.fullname);
      _id = _prefs.getInt(Data.id);
    } else {
      _value = 0;
      _level = 0;
      _id = 0;
      _username = null;
      _loggedIn = false;
    }
    notifyListeners();
  }

  Future<void> savePref({
    String email,
    String username,
    int level,
    int id,
    String phone,
    String createdDate,
  }) async {
    await _initPrefs();

    _prefs.setInt(Data.id, id);
    _prefs.setString(Data.email, email);
    _prefs.setString(Data.fullname, username);
    _prefs.setInt(Data.level, level);
    _prefs.setString(Data.createdDate, createdDate);
    _prefs.setString(Data.phone, phone);
    _prefs.setBool(Data.loggedIn, true);
    _email = email;
    _username = username;
    _level = level;
    _phone = phone;
    _id = id;
    notifyListeners();
  }

  Future<void> deletePref() async {
    await _initPrefs();
    _prefs.remove(Data.id);
    _prefs.remove(Data.email);
    _prefs.remove(Data.fullname);
    _prefs.remove(Data.phone);
    _prefs.remove(Data.createdDate);
    _prefs.remove(Data.level);
    _prefs.remove(Data.loggedIn);
    _prefs.clear();
    setClear();
    AppModule.contextToast(
        msg: "Logout berhasil", isBottom: false, shortTime: false);

    notifyListeners();
  }

  saveSaldo(BuildContext context) async {
    await _initPrefs();

    if (_level != 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LoginScreen(),
          ));
    } else {
      _saldo = 500000;
      _prefs.setInt("saldo", _saldo ?? 0);
      _prefs.setBool("isClaimed", true);
    }
    notifyListeners();
  }

  userTransac(BuildContext context, String payment, int amount) async {
    await _initPrefs();
    if (_saldo < amount) {
      AppModule.showInfo(msg: "Saldo anda tidak mencukupi", color: Colors.red);
    } else {
      var jumlahKurang = _saldo -= amount;
      _prefs.setInt("saldo", jumlahKurang);
      Provider.of<CartProvider>(context, listen: false)
          .checkout(context, payment, jumlahKurang);
      AppModule.showConfirmation(context,
          title: "Berhasil",
          content:
              "Pembayaran menggunakan $payment berhasil, sisa saldo kamu sekarang adalah Rp. $jumlahKurang",
          confirmText: "Oke",
          cancelText: "", onPressed: () {
        Navigator.pop(context);
      });
    }
    notifyListeners();
  }

  getSaldo(BuildContext context) async {
    await _initPrefs();
    _saldo = _prefs.getInt("saldo") ?? 0;
    _userClaimed = _prefs.getBool("isClaimed");
    print("user: $_userClaimed");
    notifyListeners();
  }

  setClear() {
    _username = null;
    _phone = null;
    _level = 0;
    _id = 0;
    _loggedIn = false;
  }
}
