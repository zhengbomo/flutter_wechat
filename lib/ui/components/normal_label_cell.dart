import 'package:flutter/material.dart';

class NormalLabelCell extends StatelessWidget {
  final String text;

  NormalLabelCell(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 5, 12, 5),
      child: Text(
        this.text,
        style: TextStyle(color: Colors.black54),
      ),
    );
  }
}
