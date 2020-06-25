import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/shares.dart';

class BMAppBar extends StatelessWidget {
  final Widget title;
  final List<Widget> actions;
  BMAppBar({this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        // 去掉水波纹效果
        splashFactory: Shares.noInkFeatureFactory,
      ),
      child: AppBar(
        elevation: 0,
        centerTitle: true,
        title: this.title,
        actions: this.actions
      )
    );
  }
}