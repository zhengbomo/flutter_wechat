import 'package:flutter/material.dart';

class ValueChangeNotifier<T> extends ChangeNotifier {
  T value;
  ValueChangeNotifier({this.value});

  setValue(T t) {
    if (value != t) {
      value = t;
      notifyListeners();
    }
  }
}
