import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterwechat/data/constants/constants.dart';
import 'package:flutterwechat/data/providers/main_badge_model.dart';
import 'package:flutterwechat/ui/page/base/auto_keep_alive_state.dart';
import 'package:flutterwechat/ui/page/contacts/contact_list.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends AutoKeepAliveState<ContactsPage> {
  // Appbar高度，默认为safeTop
  double _appBarTop = 0;
  // 动画
  int _duration = 0;

  // AppBar高度
  double _appBarHeight = kToolbarHeight;
  double _listViewTop = kToolbarHeight;

  double _releaseOffset;

  bool _isSearchMode = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Container(
          // constraints: BoxConstraints.expand(),
          child: Stack(overflow: Overflow.visible, children: <Widget>[
            // 列表
            AnimatedPositioned(
              left: 0,
              right: 0,
              top: MediaQuery.of(context).padding.top + _listViewTop,
              bottom: 0,
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: _duration),
              child: ContactList(
                textFieldFocusChanged: (bool focus) {
                  _isSearchMode = focus;
                  if (focus) {
                    _duration = 250;
                    setState(() {
                      _appBarTop =
                          -kToolbarHeight - MediaQuery.of(context).padding.top;
                      _listViewTop = 0;
                    });
                  } else {
                    _duration = 250;
                    setState(() {
                      _appBarTop = 0;
                      _listViewTop = kToolbarHeight;
                    });
                  }
                },
                dragOffsetChanged: (DragBehavior t1, double offset, draging) {
                  print("offset=$_releaseOffset, draging=$draging");
                  // if (_releaseOffset < -150) {
                  //   // 小程序
                  //   _duration = 0;
                  //   setState(() {
                  //     _appBarTop = 0;
                  //     _listViewTop = _appBarTop;
                  //   });
                  // }
                  switch (t1) {
                    case DragBehavior.dragStart:
                      _releaseOffset = null;
                      setState(() {
                        _duration = 0;
                        if (offset <= 0 && _appBarTop != -offset) {
                          _appBarTop = -offset;
                        }
                      });
                      break;
                    case DragBehavior.dragChanging:
                      if (_releaseOffset == null && !draging) {
                        _releaseOffset = offset;
                        if (_releaseOffset < -150) {
                          // 开启小程序
                        }
                      }

                      if (offset <= 0) {
                        if (_appBarTop != -offset) {
                          setState(() {
                            _appBarTop = -offset;
                          });
                        }
                      }
                      break;
                    case DragBehavior.dragEnd:
                      if (_appBarTop != 0) {
                        setState(() {
                          _appBarTop = 0;
                        });
                      }
                      break;
                  }
                },
              ),
            ),
            // 小程序
            AnimatedPositioned(
                left: 0,
                right: 0,
                top: -MediaQuery.of(context).size.height + _appBarTop,
                curve: Curves.easeInOut,
                duration: Duration(milliseconds: _duration),
                child: Container(
                  color: Colors.green,
                  height: MediaQuery.of(context).size.height,
                )),
            // 搜索
            AnimatedPositioned(
              left: 0,
              right: 0,
              top: _appBarHeight + _listViewTop + Constant.listSearchBarHeight,
              bottom: 0,
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: _duration),
              child: Offstage(
                offstage: !_isSearchMode,
                child: Container(
                  color: Colors.green,
                ),
              ),
            ),
            // 导航栏
            AnimatedPositioned(
              left: 0,
              right: 0,
              top: _appBarTop,
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: _duration),
              child: AppBar(
                centerTitle: true,
                title: Text("通讯录"),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      _duration = 250;
                      setState(() {
                        _appBarTop = 0;
                        // _listViewTop = kToolbarHeight;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      var model = context.read<MainBadgeModel>();
                      model.showBottomTabBar(!model.isShowBottomTabBar);
                      // _duration = 250;
                      // setState(() {
                      //   _appBarTop = -kToolbarHeight +
                      //       MediaQuery.of(context).padding.top;
                      //   // _listViewTop = _appBarTop;
                      // });
                    },
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
