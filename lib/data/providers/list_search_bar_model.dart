import 'package:flutter/foundation.dart';

class ListSearchBarModel extends ChangeNotifier {
  bool _isFocus = false;
  bool get isFocus => _isFocus;

  changeFocus(bool isFocus) {
    if (_isFocus != isFocus) {
      _isFocus = isFocus;
      notifyListeners();
    }
  }
}
