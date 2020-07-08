import 'package:flutter/material.dart';

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
      width: this.size,
      height: this.size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(this.borderRadius),
        color: this.color,
      ),
    );
  }
}
