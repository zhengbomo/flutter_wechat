import 'package:flutter/material.dart';

class LinkButton extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final VoidCallback onPressed;
  LinkButton({
    @required this.child,
    @required this.onPressed,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: this.padding,
      child: this.child,
      onPressed: this.onPressed,
    );
  }
}
