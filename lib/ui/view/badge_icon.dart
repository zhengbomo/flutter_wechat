import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/style.dart';

class BadgeIcon extends StatelessWidget {
  final String title;
  final Widget icon;

  BadgeIcon({this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    Widget badgeView;
    if (this.title == null) {
      badgeView = null;
    } else if (this.title.isEmpty) {
      badgeView = Positioned(
          right: -6,
          top: -3,
          child: Container(
            width: 12,
            height: 12,
            child: CircleAvatar(
              backgroundColor: Style.redBadgeColor,
            ),
          ));
    } else {
      badgeView = Positioned(
          left: 15,
          top: -3,
          child: Container(
              height: 18,
              decoration: BoxDecoration(
                  color: Style.redBadgeColor,
                  borderRadius: BorderRadius.all(Radius.circular(9))),
              padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
              child: Center(
                  child: Text(title,
                      style: TextStyle(color: Colors.white, fontSize: 14)))));
    }
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[icon, if (badgeView != null) badgeView],
    );
  }
}
