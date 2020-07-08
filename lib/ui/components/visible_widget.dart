import 'package:flutter/material.dart';

class VisiableWidget extends StatefulWidget {
  bool show;
  Widget child;

  @override
  _VisiableWidgetState createState() => _VisiableWidgetState();
}

class _VisiableWidgetState extends State<VisiableWidget> {
  @override
  Widget build(BuildContext context) {
    return Offstage(
        // this.
        );
  }
}
