import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';


class MainChatModel with ChangeNotifier {
  bool showMenu = false;

  void setShowMenu(bool show) {
    if (showMenu != show) {
      showMenu = show;
      notifyListeners();
    }
  }
}