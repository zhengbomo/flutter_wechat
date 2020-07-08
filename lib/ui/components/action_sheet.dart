import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/style.dart';

class ActionSheet extends StatelessWidget {
  final Widget header;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  ActionSheet(
      {@required this.itemCount, @required this.itemBuilder, this.header});

  @override
  Widget build(BuildContext context) {
    var list = List<Widget>();
    if (this.header != null) {
      list.add(this.header);
    }
    for (int i = 0; i < itemCount; i++) {
      if (i == itemCount - 1) {
        Widget item = itemBuilder(context, i);
        list.add(item);
      } else {
        Widget item = itemBuilder(context, i);
        list.add(item);
        list.add(Divider(height: 1));
      }
    }

    final paddingBottom = MediaQuery.of(context).padding.bottom;
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.only(
      //     topLeft: Radius.circular(12),
      //     topRight: Radius.circular(12),
      //   ),
      //   color: Colors.white,
      // ),
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ...list,
            Container(
              height: 8,
              color: Style.primaryColor,
            ),
            FlatButton(
              padding: EdgeInsets.zero,
              child: Padding(
                child: SizedBox(height: 50, child: Center(child: Text("取消"))),
                padding: EdgeInsets.only(bottom: paddingBottom),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future show<T>(BuildContext context) {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return ActionSheet(
            itemCount: 2,
            itemBuilder: (c, i) {
              if (i == 0) {
                return SizedBox(
                  height: 70,
                  child: FlatButton(
                    padding: EdgeInsets.zero,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "拍摄",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "照片或视频",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black26,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                );
              } else {
                return SizedBox(
                  height: 60,
                  child: FlatButton(
                    padding: EdgeInsets.zero,
                    child: Text(
                      "从手机相册选择",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                );
              }
            },
          );
        });
  }
}
