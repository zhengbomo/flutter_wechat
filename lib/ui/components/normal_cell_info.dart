import 'package:flutter/material.dart';

class NormalCellInfo {
  Widget icon;
  String title;
  bool showArrow;
  Widget leading;
  VoidCallback onPressed;

  NormalCellInfo({
    @required this.title,
    this.icon,
    this.onPressed,
    this.leading,
    this.showArrow = true,
  });
}
