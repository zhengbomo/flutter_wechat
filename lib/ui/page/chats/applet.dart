import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/constants.dart';
import 'package:flutterwechat/ui/view/search_bar.dart';

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
      // color: Colors.cyan,
      child: SizedBox(
        height: 50 * 2 + 100.0 * 2 + Constant.searchBarHeight,
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
                  children: List.generate(
                      4,
                      (index) => Container(
                            margin: EdgeInsets.all(12),
                            height: 80,
                            width: 60,
                            color: Colors.green,
                          )),
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
                  children: List.generate(
                      4,
                      (index) => Container(
                            margin: EdgeInsets.all(12),
                            height: 80,
                            width: 60,
                            color: Colors.green,
                          )),
                ),
              ),
              SizedBox(
                height: Constant.searchBarHeight,
              )
            ],
          ),
        ),
      ),
    );
  }
}
