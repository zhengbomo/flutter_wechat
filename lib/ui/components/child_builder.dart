import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/basic.dart';

class ChildBuilder1 extends StatelessWidget {
  final Widget child1;
  final TwoValueResult<BuildContext, Widget, Widget> builder;

  ChildBuilder1({
    Key key,
    @required this.child1,
    @required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => this.builder(context, child1);
}

class ChildBuilder2 extends StatelessWidget {
  final Widget child1;
  final Widget child2;
  final ThreeValueResult<BuildContext, Widget, Widget, Widget> builder;

  ChildBuilder2({
    Key key,
    @required this.child1,
    @required this.child2,
    @required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => this.builder(context, child1, child2);
}

class ChildBuilder3 extends StatelessWidget {
  final Widget child1;
  final Widget child2;
  final Widget child3;
  final FourValueResult<BuildContext, Widget, Widget, Widget, Widget> builder;

  ChildBuilder3({
    Key key,
    @required this.child1,
    @required this.child2,
    @required this.child3,
    @required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      this.builder(context, child1, child2, child3);
}

class ChildBuilder4 extends StatelessWidget {
  final Widget child1;
  final Widget child2;
  final Widget child3;
  final Widget child4;
  final FiveValueResult<BuildContext, Widget, Widget, Widget, Widget, Widget>
      builder;

  ChildBuilder4({
    Key key,
    @required this.child1,
    @required this.child2,
    @required this.child3,
    @required this.child4,
    @required this.builder,
  });

  @override
  Widget build(BuildContext context) =>
      this.builder(context, child1, child2, child3, child4);
}

class ChildBuilder5 extends StatelessWidget {
  final Widget child1;
  final Widget child2;
  final Widget child3;
  final Widget child4;
  final Widget child5;
  final SixValueResult<BuildContext, Widget, Widget, Widget, Widget, Widget,
      Widget> builder;

  ChildBuilder5({
    Key key,
    @required this.child1,
    @required this.child2,
    @required this.child3,
    @required this.child4,
    @required this.child5,
    @required this.builder,
  });

  @override
  Widget build(BuildContext context) =>
      this.builder(context, child1, child2, child3, child4, child5);
}

class ChildBuilder6 extends StatelessWidget {
  final Widget child1;
  final Widget child2;
  final Widget child3;
  final Widget child4;
  final Widget child5;
  final Widget child6;
  final SevenValueResult<BuildContext, Widget, Widget, Widget, Widget, Widget,
      Widget, Widget> builder;

  ChildBuilder6({
    Key key,
    @required this.child1,
    @required this.child2,
    @required this.child3,
    @required this.child4,
    @required this.child5,
    @required this.child6,
    @required this.builder,
  });

  @override
  Widget build(BuildContext context) =>
      this.builder(context, child1, child2, child3, child4, child5, child6);
}

class ChildBuilder7 extends StatelessWidget {
  final Widget child1;
  final Widget child2;
  final Widget child3;
  final Widget child4;
  final Widget child5;
  final Widget child6;
  final Widget child7;
  final EightValueResult<BuildContext, Widget, Widget, Widget, Widget, Widget,
      Widget, Widget, Widget> builder;

  ChildBuilder7({
    Key key,
    @required this.child1,
    @required this.child2,
    @required this.child3,
    @required this.child4,
    @required this.child5,
    @required this.child6,
    @required this.child7,
    @required this.builder,
  });

  @override
  Widget build(BuildContext context) => this
      .builder(context, child1, child2, child3, child4, child5, child6, child7);
}
