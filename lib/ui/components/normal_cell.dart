import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/constants.dart';
import 'package:flutterwechat/ui/components/common_arrow.dart';

class NormalCellInfo {
  Widget icon;
  String title;
  bool showArrow;
  Widget trailing;
  VoidCallback onPressed;

  NormalCellInfo({
    @required this.title,
    this.icon,
    this.onPressed,
    this.trailing,
    this.showArrow = true,
  });
}

class NormalCell extends StatelessWidget {
  final NormalCellInfo cellInfo;

  NormalCell({@required this.cellInfo});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Constant.normalCellHeight,
      child: FlatButton(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  if (cellInfo.icon != null) cellInfo.icon,
                  Expanded(
                    child: Padding(
                      child: Text(cellInfo.title),
                      padding: EdgeInsets.only(
                          left: cellInfo.icon != null ? 12 : 0, right: 12),
                    ),
                  ),
                  if (cellInfo.trailing != null) cellInfo.trailing,
                  if (cellInfo.showArrow) CommonArrow(),
                ],
              ),
            ),
            Divider(
              height: 1,
              indent: 36,
            )
          ],
        ),
        onPressed: cellInfo.onPressed,
      ),
    );
  }
}
