import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/constants.dart';
import 'package:flutterwechat/ui/components/common_arrow.dart';

class NormalCellInfo {
  Widget icon;
  String title;
  bool showArrow;
  Widget trailing;
  VoidCallback onPressed;
  bool hideSeperator;

  NormalCellInfo({
    @required this.title,
    this.icon,
    this.onPressed,
    this.trailing,
    this.hideSeperator = false,
    this.showArrow = true,
  });
}

class NormalCell extends StatelessWidget {
  final double dividerIndent;
  final double dividerEndIndent;

  final NormalCellInfo cellInfo;

  NormalCell({
    @required this.cellInfo,
    this.dividerIndent = 16,
    this.dividerEndIndent = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: Constant.kNormalCellMinHeight),
      child: FlatButton(
        padding: EdgeInsets.zero,
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: Theme.of(context).buttonTheme.padding,
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
                  if (cellInfo.showArrow)
                    SizedBox(
                      height: Constant.kNormalCellMinHeight,
                      child: CommonArrow(),
                    ),
                ],
              ),
            ),
            if (!cellInfo.hideSeperator)
              Divider(
                indent: dividerIndent,
                endIndent: dividerEndIndent,
                height: 1,
              ),
          ],
        ),
        onPressed: cellInfo.onPressed,
      ),
    );
  }
}
