import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/constants.dart';

class Avatar extends StatelessWidget {
  final Color color;
  final double size;
  final double borderRadius;

  Avatar({
    @required this.color,
    this.size,
    this.borderRadius = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(this.borderRadius),
        color: this.color,
        image: DecorationImage(
          image: AssetImage(
            Constant.assetsImagesCommon.named("tableview_arrow.png"),
          ),
        ),
      ),
      child: FlatButton(
        padding: EdgeInsets.zero,
        child: Container(
          width: this.size,
          height: this.size,
        ),
        onPressed: () {},
      ),
    );
  }
}
