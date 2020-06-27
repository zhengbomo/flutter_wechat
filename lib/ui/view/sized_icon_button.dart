import 'package:flutter/material.dart';


class SizedIconButton extends StatelessWidget {
  
  final double height;
  final double width;
  final Widget icon;
  final double iconSize;
  final Color color;
  final VoidCallback onPressed;

  SizedIconButton({
    Key key, 
    this.height,
    this.width,
    @required this.icon,
    this.color,
    this.iconSize = 24,
    @required this.onPressed
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: this.width,
      height: this.height,
      child: IconButton(
        onPressed: this.onPressed,
        iconSize: this.iconSize,
        icon: this.icon,
      )
    );
  }
}