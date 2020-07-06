import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/constants.dart';

class CommonArrow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Constant.assetsImagesCommon.named("tableview_arrow.png"),
      width: 8,
    );
  }
}
