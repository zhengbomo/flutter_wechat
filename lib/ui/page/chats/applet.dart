import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/constants.dart';
import 'package:flutterwechat/ui/components/avatar.dart';
import 'package:flutterwechat/ui/view/search_bar.dart';
import 'package:flutterwechat/utils/build_context_read.dart';

class Applet extends StatefulWidget {
  @override
  _AppletState createState() => _AppletState();
}

class _AppletState extends State<Applet> {
  ScrollController _controller =
      ScrollController(initialScrollOffset: Constant.searchBarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        height: 50 * 2 + 100.0 * 2 + Constant.searchBarHeight,
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollEndNotification) {
              if (notification.metrics.pixels < Constant.searchBarHeight &&
                  notification.metrics.pixels > 0) {
                print(notification.metrics.pixels);

                double offset = 0;
                if (notification.metrics.pixels >
                    Constant.searchBarHeight * 0.5) {
                  offset = Constant.searchBarHeight;
                } else {}
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  _controller.animateTo(offset,
                      duration: Constant.kCommonDuration,
                      curve: Curves.easeInOut);
                });
              }
            }

            return false;
          },
          child: SingleChildScrollView(
            controller: _controller,
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: Constant.searchBarHeight,
                  child: SearchBar(beginEdit: () {
                    // 编辑
                  }, cancelCallback: () {
                    // 取消编辑
                  }),
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.only(left: 24),
                  alignment: Alignment.centerLeft,
                  child: Text("最近使用"),
                ),
                Container(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) => _createItem(context)),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 24),
                  height: 50,
                  child: Text("我的小程序"),
                ),
                Container(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) => _createItem(context)),
                  ),
                ),
                SizedBox(
                  height: Constant.searchBarHeight,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _createItem(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      width: context.getInheritedWidget<MediaQuery>().data.size.width / 4,
      child: Column(
        children: <Widget>[
          Avatar(
            color: Colors.green,
            size: 50,
            borderRadius: 25,
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text("王者荣耀",
                style: TextStyle(fontSize: 12, color: Colors.black87)),
          )
        ],
      ),
    );
  }
}
