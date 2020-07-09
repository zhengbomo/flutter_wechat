import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterwechat/data/constants/constants.dart';

class BMAppBar extends StatelessWidget with PreferredSizeWidget {
  final Widget title;
  final Color color;
  final Color backgroundColor;
  final List<Widget> actions;
  final double elevation;

  BMAppBar({
    this.title,
    this.actions,
    this.backgroundColor,
    this.color,
    this.elevation = 0,
  });

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
      elevation: elevation,
      centerTitle: true,
      title: this.title,
      actions: this.actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
