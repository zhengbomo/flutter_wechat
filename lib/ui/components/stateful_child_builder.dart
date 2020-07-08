import 'package:flutter/material.dart';

typedef StatefulChildWidgetBuilder = Widget Function(
    BuildContext context, StateSetter setState, Widget child);

class StatefulChildWidget extends StatefulWidget {
  final Widget child;
  final StatefulChildWidgetBuilder builder;

  const StatefulChildWidget({
    Key key,
    this.child,
    @required this.builder,
  })  : assert(builder != null),
        super(key: key);

  @override
  _StatefulChildWidgetState createState() => _StatefulChildWidgetState();
}

class _StatefulChildWidgetState extends State<StatefulChildWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.builder(context, setState, widget.child);
  }
}
