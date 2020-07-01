import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/constants.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController textEditingController;
  final FocusNode focusNode;

  SearchBar({@required this.textEditingController, @required this.focusNode});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final double _cancelWidth = 60;

  String _hintText = "";

  bool _hasFocus = false;

  double _cancelRight = 8;
  double _iconPadding = 30;

  double get _textFieldRight => _cancelWidth + 8 + _cancelRight;

  @override
  void initState() {
    widget.focusNode.addListener(() {
      _hasFocus = widget.focusNode.hasFocus;
      if (_hasFocus) {
        onFocus();
      } else {
        onUnFocus();
      }
      // setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: Constant.listSearchBarHeight,
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.passthrough,
              children: <Widget>[
                AnimatedPositioned(
                  left: 8,
                  right: _textFieldRight,
                  top: 0,
                  bottom: 0,
                  duration: Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    // margin: EdgeInsets.fromLTRB(40, 0, 80, 0),
                    child: NotificationListener(
                      onNotification: (notification) {
                        return false;
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                        child: TextField(
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 3),
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.black38,
                              ),
                              border: InputBorder.none,
                              hintText: _hintText),
                          scrollPhysics: NeverScrollableScrollPhysics(),
                          maxLines: 1,
                          controller: widget.textEditingController,
                          focusNode: widget.focusNode,
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  right: _cancelRight,
                  top: 0,
                  width: _cancelWidth,
                  bottom: 0,
                  curve: Curves.easeInOut,
                  duration: Duration(milliseconds: 250),
                  child: FlatButton(
                    padding: EdgeInsets.zero,
                    child: Text("取消"),
                    onPressed: () {
                      widget.focusNode.unfocus();
                    },
                  ),
                ),
                AnimatedPositioned(
                  onEnd: () {
                    if (_hasFocus) {
                      setState(() {
                        _hintText = "搜索";
                      });
                    }
                  },
                  top: 0,
                  bottom: 0,
                  left: _iconPadding,
                  curve: Curves.easeInOut,
                  duration: Duration(milliseconds: 250),
                  child: IgnorePointer(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      width: 50,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.search,
                            size: 20,
                            color: Colors.black38,
                          ),
                          Spacer(),
                          Offstage(
                            offstage: _hintText != "",
                            child: Text(
                              "搜索",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black38,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  onFocus() {
    setState(() {
      _iconPadding = 8.0 + 8;
      _cancelRight = 8;
    });
  }

  onUnFocus() {
    print("unfocus");
    setState(() {
      _hintText = "";
      _iconPadding = (MediaQuery.of(context).size.width - 50) * 0.5;
      _cancelRight = -_cancelWidth;
    });
  }
}
