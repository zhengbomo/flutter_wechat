import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String assetName;
  final Color color;
  final double iconSize;
  final Size maxSize;

  SvgIconButton(
      {@required this.assetName,
      @required this.onPressed,
      @required this.color,
      @required this.iconSize,
      @required this.maxSize});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: maxSize.height, maxWidth: maxSize.width),
      child: IconButton(
        color: color,
        onPressed: onPressed,
        iconSize: iconSize,
        // color: color,
        icon: SvgPicture.asset(
          assetName,
          color: color,
          width: iconSize,
          height: iconSize,
        ),
      ),
    );
  }
}
