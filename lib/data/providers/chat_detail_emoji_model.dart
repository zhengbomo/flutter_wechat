import 'package:flutter/material.dart';

class ChatDetailEmojiModel extends ChangeNotifier {
  int index = 0;
  double offset = 0.0;

  void setIndex(int index) {
    if (this.index != index) {
      this.index = index;
      notifyListeners();
    }
  }
}
