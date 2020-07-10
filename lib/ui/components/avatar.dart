import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final Color color;
  final double size;
  final double borderRadius;
  final bool userInteractionEnable;

  Avatar({
    @required this.color,
    this.size,
    this.borderRadius = 3,
    this.userInteractionEnable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: this.userInteractionEnable
          ? FlatButton(
              padding: EdgeInsets.zero,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(this.borderRadius),
                  color: this.color,
                ),
                width: this.size,
                height: this.size,
              ),
              onPressed: () {},
            )
          : Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(this.borderRadius),
                color: this.color,
              ),
              width: this.size,
              height: this.size,
            ),
    );
  }
}
