import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/constants.dart';

class ListSearchBarModel extends ChangeNotifier {
  Duration _appbarDuration = Constant.kCommonDuration;
  Duration get appbarDuration => _appbarDuration;
  set appbarDuration(Duration duration) {
    _appbarDuration = duration;
    if (duration.inMilliseconds > 0) {
      print(duration);
    }
  }

  double _appbarOffset = 0;
  double _listViewOffset = 0;

  double get appbarOffset => _appbarOffset;
  set appbarOffset(double offset) {
    if (_appbarOffset != offset) {
      _appbarOffset = offset;
      notifyListeners();
    }
  }

  double get listViewOffset => _listViewOffset;
  set listViewOffset(double offset) {
    if (_listViewOffset != offset) {
      _listViewOffset = offset;
      notifyListeners();
    }
  }

  bool _isFocus = false;
  bool get isFocus => _isFocus;

  changeFocus(bool isFocus) {
    if (_isFocus != isFocus) {
      _isFocus = isFocus;
      notifyListeners();
    }
  }
}
