import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/basic.dart';
import 'package:flutterwechat/data/constants/constants.dart';

class IndexBar extends StatefulWidget {
  final ThreeValueResult<BuildContext, int, bool, Widget> builder;

  final IndexedWidgetBuilder bubbleWidgetBuilder;

  final int itemCount;
  final int index;
  final ValueChanged<int> indexChanged;
  IndexBar({
    @required this.bubbleWidgetBuilder,
    @required this.index,
    @required this.itemCount,
    @required this.indexChanged,
    @required this.builder,
  });
  @override
  _IndexBarState createState() => _IndexBarState();
}

class _IndexBarState extends State<IndexBar> {
  final double _itemHeight = 30;

  bool _isDraging = false;

  // 只有点击的时候才有值，否则为null
  int _dragingIndex;
  double _dragingTop;

  _dragUpdate(double dy, double indexHeight, double parentHeight) {
    final index = dy ~/ _itemHeight;
    final newIndex = max(0, min(index, widget.itemCount - 1));
    if (_dragingIndex != newIndex) {
      widget.indexChanged(newIndex);

      setState(() {
        _dragingTop = parentHeight * 0.5 -
            indexHeight * 0.5 +
            newIndex * _itemHeight -
            (40 - 30) * 0.5;
        _dragingIndex = newIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.passthrough,
        children: <Widget>[
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            width: 40,
            child: Center(
              child: Builder(builder: (gesContext) {
                return GestureDetector(
                  onPanStart: (data) {
                    _isDraging = true;
                    // 获取相对位置
                    RenderBox parentBox = context.findRenderObject();
                    RenderBox gesBox = gesContext.findRenderObject();
                    _dragUpdate(data.localPosition.dy, gesBox.size.height,
                        parentBox.size.height);
                  },
                  onPanEnd: (data) {
                    _isDraging = false;
                    _dragingIndex = null;
                    // update
                    setState(() {});
                  },
                  onPanUpdate: (data) {
                    // 获取相对位置
                    RenderBox parentBox = context.findRenderObject();
                    RenderBox gesBox = gesContext.findRenderObject();
                    _dragUpdate(data.localPosition.dy, gesBox.size.height,
                        parentBox.size.height);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ...List.generate(widget.itemCount, (i) {
                        bool selected =
                            i == (_isDraging ? _dragingIndex : widget.index);

                        return SizedBox(
                          width: _itemHeight,
                          height: _itemHeight,
                          child: widget.builder(context, i, selected),
                        );
                      })
                    ],
                  ),
                );
              }),
            ),
          ),
          Positioned(
            left: 0,
            top: _dragingTop,
            child: Offstage(
              offstage: _dragingIndex == null,
              child: Builder(builder: (context) {
                final bubbleContent = widget.bubbleWidgetBuilder(
                  context,
                  _isDraging ? _dragingIndex : widget.index,
                );
                if (bubbleContent != null) {
                  return Padding(
                    padding: EdgeInsets.zero,
                    child: Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Image.asset(
                            Constant.assetsImagesContacts
                                .named("contact_index_shape.png"),
                            width: 50,
                            height: 50,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 3),
                            child: bubbleContent,
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return SizedBox();
                }
              }),
            ),
          )
        ],
      ),
    );
  }
}
