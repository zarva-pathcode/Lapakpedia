import 'package:flutter/cupertino.dart';
import 'package:flutter_app/app/logic/models/history.dart';
import 'package:flutter_app/app/logic/provider/auth_data.dart';
import 'package:flutter_app/app/logic/repository/history_repo.dart';
import 'package:provider/provider.dart';

class HistoryProvider extends ChangeNotifier {
  int value;
  String message;
  bool isNull = true;
  bool oneTime = false;
  bool isLoading = false;
  var totalCount = 0;
  var saldoUser = 0;
  List<History> list = [];

  getHistory(BuildContext context) async {
    isLoading = true;
    list.clear();
    notifyListeners();
    final data = await HistoryRepo.getHistory(
        Provider.of<AuthData>(context, listen: false).uid.toString());

    if (data == null) {
      isLoading = true;
      isNull = true;
    } else {
      for (Map i in data) {
        list.add(History.fromJson(i));
      }

      isLoading = true;
      isNull = false;
    }
    notifyListeners();
  }

  saldo(BuildContext context) {
    saldoUser = 500000;

    Provider.of<AuthData>(context, listen: false).saveSaldo(context);

    // Provider.of<AuthData>(context, listen: false).userClaimed;
    notifyListeners();
  }

  getSaldoFromAuth(int saldoFrom, bool isClaimed) {
    saldoUser = saldoFrom;
    oneTime = isClaimed;
    notifyListeners();
  }
}
