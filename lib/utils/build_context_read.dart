import 'package:flutter/material.dart';

extension BuildContextRead on BuildContext {
  T getInheritedWidget<T extends InheritedWidget>({bool listen = false}) {
    if (listen) {
      return this.dependOnInheritedWidgetOfExactType<T>();
    } else {
      return this.getElementForInheritedWidgetOfExactType<T>().widget as T;
    }
  }
}
