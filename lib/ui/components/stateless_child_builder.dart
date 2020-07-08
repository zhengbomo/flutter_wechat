import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/basic.dart';

class StatelessChildBuilder extends StatelessWidget {
  const StatelessChildBuilder({
    Key key,
    @required this.builder,
    @required this.child,
  })  : assert(builder != null),
        super(key: key);

  final TwoValueResult<BuildContext, Widget, Widget> builder;
  final Widget child;

  @override
  Widget build(BuildContext context) => builder(context, this.child);
}
