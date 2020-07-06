import 'package:flutter/material.dart';

class NavigatorService {
  static final _navigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
  static NavigatorState get state => navigatorKey.currentState;

  static Future<T> push<T extends Widget>(T page) {
    return state.push(MaterialPageRoute(builder: (context) => page));
  }
}
