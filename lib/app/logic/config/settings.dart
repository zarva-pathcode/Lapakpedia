import 'package:flutter/material.dart';

class Settings with ChangeNotifier {
  bool _secureText = false;
  bool isDark = false;

  bool get secureText => _secureText = !_secureText;

  showHide() {
    _secureText = !_secureText;
  }

  changeTheme() {
    isDark = !isDark;
  }

  @override
  void notifyListeners() {
    showHide();
    changeTheme();
    super.notifyListeners();
  }
}
