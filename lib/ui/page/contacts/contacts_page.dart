import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterwechat/ui/page/contacts/applet_panel.dart';
import 'package:provider/provider.dart';
import 'package:flutterwechat/data/constants/constants.dart';
import 'package:flutterwechat/data/providers/main_badge_model.dart';
import 'package:flutterwechat/ui/page/base/auto_keep_alive_state.dart';
import 'package:flutterwechat/ui/page/contacts/contact_list.dart';

enum ListMode { normal, search, applet }

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends AutoKeepAliveState<ContactsPage> {
  ScrollController _scrollController = ScrollController();

  // Appbar高度，默认为safeTop
  double _appBarTop = 0;

  // -appbarHeight - padding
  // offset(滚动)
  // viewheight - appbarHeight - padding
  // viewheight - appbarHeight + offset

  // 动画
  int _duration = 0;

  // AppBar高度
  double _appBarHeight = kToolbarHeight;
  double _listViewTop = kToolbarHeight;

  // ContactList滑动释放位置
  double _releaseOffset;

  bool _isDraging = false;

  bool _isRefreshing = false;

  ListMode _listMode = ListMode.normal;

  double _appletOffset = 0;

  bool _isOpenApplet = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final query = MediaQuery.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Container(
          constraints: BoxConstraints.expand(),
          child: Stack(overflow: Overflow.visible, children: <Widget>[
            // 列表
            AnimatedPositioned(
              left: 0,
              right: 0,
              top: query.padding.top + _listViewTop,
              bottom: 0,
              // height: 400,
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: _duration),
              child: ContactList(
                onEdit: () {
                  _listMode = ListMode.search;
                  _duration = 250;
                  setState(() {
                    // 处理AppBar
                    _appBarTop = -kToolbarHeight - query.padding.top;
                    _listViewTop = 0;
                  });
                  // 显示TabBar
                  var model = context.read<MainBadgeModel>();
                  model.showBottomTabBar(false);
                },
                dragOffsetChanged: (DragBehavior t1, double offset, draging) {
                  switch (t1) {
                    case DragBehavior.dragStart:
                      print("drag start");
                      _releaseOffset = null;
                      setState(() {
                        // 处理AppBar
                        _duration = 0;
                        if (offset <= 0 && _appBarTop != -offset) {
                          _appBarTop = -offset;
                        }
                      });
                      break;
                    case DragBehavior.dragChanging:
                      _isDraging = draging;
                      if (_isRefreshing) {
                        return;
                      }
                      if (_releaseOffset == null && !draging) {
                        _releaseOffset = offset;
                        if (_releaseOffset < -150) {
                          if (!_isRefreshing) {
                            // 开启小程序
                            _listMode = ListMode.applet;
                            _isOpenApplet = true;
                            _isRefreshing = true;
                            print("开始动画 ${DateTime.now()}");

                            _duration = 250;

                            _appletOffset = 1;
                            setState(() {
                              _listViewTop =
                                  query.size.height - query.padding.top * 2;
                              _appBarTop = _listViewTop - kToolbarHeight;
                            });
                            // 显示TabBar
                            var model = context.read<MainBadgeModel>();
                            model.showBottomTabBar(false);
                          }
                          return;
                        }
                      }
                      if (_listMode == ListMode.normal) {
                        if (offset <= 0) {
                          if (_appBarTop != -offset) {
                            var max = query.size.height -
                                kToolbarHeight -
                                query.padding.top;

                            _appletOffset = -offset / max;
                            _isOpenApplet = true;
                            setState(() {
                              _appBarTop = -offset;
                            });
                          }
                        }
                      }
                      break;
                    case DragBehavior.dragEnd:
                      print("drag end");
                      _releaseOffset = null;
                      if (!_isRefreshing && _listMode == ListMode.normal) {
                        if (_appBarTop != 0) {
                          setState(() {
                            _appBarTop = 0;
                          });
                        }
                      }
                      break;
                  }
                },
                cancelCallback: () {
                  _listMode = ListMode.normal;
                  _duration = 250;
                  setState(() {
                    _appBarTop = 0;
                    _listViewTop = kToolbarHeight;
                  });
                  // 显示TabBar
                  var model = context.read<MainBadgeModel>();
                  model.showBottomTabBar(true);
                },
                scrollController: _scrollController,
              ),
            ),

            // 导航栏
            AnimatedPositioned(
              onEnd: () {
                if (_isRefreshing) {
                  _isRefreshing = false;
                  print("-- 结束动画 ${DateTime.now()}");
                }
              },
              left: 0,
              right: 0,
              top: _appBarTop,
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: _duration),
              child: Offstage(
                offstage: false,
                child: AppBar(
                  centerTitle: true,
                  title: Text("通讯录"),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        _listMode = ListMode.normal;
                        _duration = 250;
                        setState(() {
                          _appBarTop = 0;
                          _listViewTop = kToolbarHeight;
                        });
                        context.read<MainBadgeModel>().showBottomTabBar(true);
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
                        //       query.padding.top;
                        //   // _listViewTop = _appBarTop;
                        // });
                      },
                    )
                  ],
                ),
              ),
            ),

            // 搜索
            AnimatedPositioned(
              left: 0,
              right: 0,
              top: _appBarHeight + _listViewTop + Constant.listSearchBarHeight,
              bottom: 0,
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: _duration),
              child: Offstage(
                offstage: _listMode != ListMode.search,
                child: Container(
                  color: Colors.green,
                ),
              ),
            ),

            // 小程序
            AnimatedPositioned(
                left: 0,
                right: 0,
                top: 0,
                curve: Curves.easeInOut,
                duration: Duration(milliseconds: _duration),
                height: query.size.height,
                child: Offstage(
                    offstage: false,
                    child: Opacity(
                      opacity: 1,
                      child: AppletPanel(
                          isOpen: _isOpenApplet,
                          animated: !_isDraging,
                          offset: _appletOffset,
                          scrollChanged: (offset, isDraging) {
                            _isDraging = isDraging;
                            if (!_isRefreshing) {
                              if (!isDraging && offset > 100) {
                                _isOpenApplet = false;
                                // 关闭小程序
                                _listMode = ListMode.normal;
                                _appletOffset = 0;
                                _isRefreshing = true;
                                print("开始动画2 ${DateTime.now()}");
                                _duration = 250;
                                setState(() {
                                  _appBarTop = 0;
                                  _listViewTop = kToolbarHeight;
                                });
                                context
                                    .read<MainBadgeModel>()
                                    .showBottomTabBar(true);
                              } else if (_listMode == ListMode.applet) {
                                _duration = 0;
                                _isOpenApplet = false;
                                final max = query.size.height -
                                    kToolbarHeight -
                                    query.padding.top;
                                _appletOffset = (max - offset) / max;

                                setState(() {
                                  _listViewTop = query.size.height -
                                      query.padding.top * 2 -
                                      offset;
                                  _appBarTop = _listViewTop - kToolbarHeight;
                                });
                              }
                            }
                          }),
                    ))),
          ]),
        ),
      ),
    );
  }
}
