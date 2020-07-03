import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/basic.dart';
import 'package:flutterwechat/ui/view/animted_scale.dart';

class AppletPanel extends StatefulWidget {
  /// 是否需要动画（drag不需要动画，最后才需要动画）
  final bool animated;

  /// 位置（0-1）
  final double offset;

  // 是否是打开panel
  final bool isOpen;

  final TwoValueCallback<double, bool> scrollChanged;
  AppletPanel(
      {@required this.scrollChanged,
      @required this.offset,
      @required this.isOpen,
      @required this.animated});

  @override
  _AppletPanelState createState() => _AppletPanelState();
}

class _AppletPanelState extends State<AppletPanel> {
  ScrollController _outController = ScrollController();
  ScrollController _controller = ScrollController();

  double _offset = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: widget.offset == 0,
      child: Container(
        child: AnimatedOpacity(
          duration:
              widget.animated ? Duration(milliseconds: 250) : Duration.zero,
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
            )),
            child: AnimatedScale(
              scale: widget.isOpen ? widget.offset * 0.5 + 0.5 : 1,
              duration:
                  widget.animated ? Duration(milliseconds: 250) : Duration.zero,
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                          height: MediaQuery.of(context).size.height -
                              kToolbarHeight * 2 -
                              MediaQuery.of(context).padding.top * 2,
                          child: NotificationListener<ScrollNotification>(
                            onNotification: (notification) {
                              if (notification is ScrollUpdateNotification) {
                                var offset = notification.metrics.pixels -
                                    notification.metrics.maxScrollExtent;
                                if (offset > 0) {
                                  widget.scrollChanged(
                                      offset, notification.dragDetails != null);

                                  setState(() {
                                    _offset = -offset;
                                  });
                                }
                              } else if (notification
                                  is ScrollEndNotification) {}
                              return false;
                            },
                            child: ListView.builder(
                              padding: EdgeInsets.only(
                                  top: kToolbarHeight +
                                      MediaQuery.of(context).padding.top),
                              controller: _controller,
                              physics: AlwaysScrollableScrollPhysics(),
                              itemBuilder: (c, i) {
                                return Container(
                                  height: 60,
                                  color: Colors.red,
                                  margin: EdgeInsets.all(12),
                                );
                              },
                              itemCount: 8,
                            ),
                          ))),
                  Positioned(
                    top: _offset,
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
      ),
    );
  }
}
