import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/constants.dart';

class NormalButtonInfo {
  String text;
  VoidCallback onPressed;

  NormalButtonInfo(this.text, {@required this.onPressed});
}

class NormalButtonCell extends StatelessWidget {
  final NormalButtonInfo info;

  NormalButtonCell({@required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: Constant.kNormalCellMinHeight,
      child: FlatButton(child: Text(info.text), onPressed: info.onPressed),
    );
  }
}
