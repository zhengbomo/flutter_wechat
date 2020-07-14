import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/basic.dart';
import 'package:flutterwechat/data/constants/constants.dart';
import 'package:flutterwechat/ui/view/animted_scale.dart';
import 'package:flutterwechat/ui/view/search_bar.dart';

class AppletPanel extends StatefulWidget {
  /// 是否需要动画（drag不需要动画，最后才需要动画）
  final bool animated;

  final EdgeInsets padding;

  /// 位置（0-1）
  final double offset;

  // 是否是打开panel
  final bool isOpen;

  final VoidCallback hideApplet;

  final TwoValueCallback<double, bool> scrollChanged;
  AppletPanel({
    @required this.hideApplet,
    @required this.scrollChanged,
    @required this.offset,
    @required this.isOpen,
    @required this.animated,
    EdgeInsets padding,
  }) : this.padding = padding ?? EdgeInsets.zero;

  @override
  _AppletPanelState createState() => _AppletPanelState();
}

class _AppletPanelState extends State<AppletPanel>
    with SingleTickerProviderStateMixin {
  ScrollController _controller =
      ScrollController(initialScrollOffset: Constant.searchBarHeight);

  double _offset = 0;

  Offset beginPosition;
  Offset endPosition;

  Duration _duration = Duration.zero;

  bool _isDraging = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedOpacity(
        duration: widget.animated ? Constant.kCommonDuration : Duration.zero,
        opacity: max(0, widget.offset - 0.2) / 0.8,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(39, 37, 57, 1),
                Color.fromRGBO(56, 53, 76, 0.5),
              ],
            ),
          ),
          child: AnimatedScale(
            scale: widget.isOpen ? widget.offset * 0.5 + 0.5 : 1,
            duration:
                widget.animated ? Constant.kCommonDuration : Duration.zero,
            child: Stack(
              overflow: Overflow.visible,
              children: [
                // Content
                AnimatedPositioned(
                  curve: Curves.easeInOut,
                  duration: _duration,
                  top: _offset + kToolbarHeight + widget.padding.top,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    color: Colors.green.withAlpha(100),
                    height: MediaQuery.of(context).size.height -
                        kToolbarHeight * 2 -
                        widget.padding.top,
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        if (notification is ScrollUpdateNotification) {
                          // if (notification.metrics.pixels >
                          //     Constant.searchBarHeight) {
                          //   _offset = -notification.metrics.pixels -
                          //       Constant.searchBarHeight +
                          //       kToolbarHeight +
                          //       widget.padding.top;
                          //   print(_offset);

                          //   setState(() {});
                          // }
                          // if (offset > 0) {
                          //   widget.scrollChanged(
                          //       offset, notification.dragDetails != null);

                          //   setState(() {
                          //     _offset = -offset;
                          //   });
                          // }
                        } else if (notification is ScrollEndNotification) {
                          print(notification);
                          if (_isDraging) {
                            if (_controller.offset < Constant.searchBarHeight) {
                              WidgetsBinding.instance
                                  .addPostFrameCallback((timeStamp) {
                                if (_controller.offset <
                                    Constant.searchBarHeight * 0.5) {
                                  _controller.animateTo(0,
                                      duration: Constant.kCommonDuration,
                                      curve: Curves.easeInOut);
                                } else {
                                  _controller.animateTo(
                                      Constant.searchBarHeight,
                                      duration: Constant.kCommonDuration,
                                      curve: Curves.easeInOut);
                                }
                              });
                            }
                            _isDraging = false;
                          }
                        } else if (notification is ScrollStartNotification) {
                          _isDraging = notification.dragDetails != null;
                        }
                        return false;
                      },
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 160.0 * 2 + Constant.searchBarHeight,
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
                                    height: 160,
                                    color: Colors.red,
                                  ),
                                  Container(
                                    height: 160,
                                    color: Colors.blue,
                                  ),
                                  Container(
                                    color: Colors.yellow,
                                    height: Constant.searchBarHeight,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Builder(
                              builder: (context) {
                                return GestureDetector(
                                  onPanStart: (data) {
                                    _duration = Duration.zero;
                                    beginPosition = data.localPosition;
                                  },
                                  onPanUpdate: (data) {
                                    endPosition = data.localPosition;

                                    final offset =
                                        endPosition.dy - beginPosition.dy;
                                    print(offset);
                                    setState(() {
                                      _offset = offset;
                                    });
                                  },
                                  onPanEnd: (data) {
                                    _duration = Constant.kCommonDuration;
                                    final offset =
                                        endPosition.dy - beginPosition.dy;
                                    print(offset);

                                    if (offset.abs() > 100) {
                                      widget.hideApplet();
                                    } else {
                                      setState(() {
                                        _offset = 0;
                                      });
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // AppBar
                AnimatedPositioned(
                  duration: _duration,
                  curve: Curves.easeInOut,
                  top: _offset + widget.padding.top,
                  left: 0,
                  right: 0,
                  height: kToolbarHeight + MediaQuery.of(context).padding.top,
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    title: Text(
                      "小程序",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
