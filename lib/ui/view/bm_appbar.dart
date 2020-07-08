import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterwechat/data/constants/constants.dart';

class BMAppBar extends StatelessWidget {
  final Widget title;
  final Color color;
  final Color backgroundColor;
  final List<Widget> actions;
  BMAppBar({this.title, this.actions, this.backgroundColor, this.color});

  @override
  Widget build(BuildContext context) {
    final canPop = ModalRoute.of(context).canPop;
    final leading = canPop
        ? IconButton(
            icon: SvgPicture.asset(
                Constant.assetsImagesCommon.named("icons_filled_back.svg"),
                color: this.color),
            onPressed: () {
              Navigator.of(context).maybePop();
            },
          )
        : null;
    return AppBar(
      backgroundColor: this.backgroundColor,
      leading: leading,
      elevation: 0,
      centerTitle: true,
      title: this.title,
      actions: this.actions,
    );
  }
}
