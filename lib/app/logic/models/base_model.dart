import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/config/state_info.dart';

class BaseModel extends ChangeNotifier {
  StateInfo _state = StateInfo.done;

  StateInfo get state => _state;

  void setState(StateInfo stateInfo) {
    _state = stateInfo;
    notifyListeners();
  }
}
