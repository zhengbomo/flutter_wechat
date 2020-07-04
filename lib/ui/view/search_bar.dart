import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/constants.dart';
import 'package:flutterwechat/data/constants/style.dart';

class SearchBar extends StatefulWidget {
  final VoidCallback beginEdit;
  final VoidCallback cancelCallback;

  SearchBar({@required this.beginEdit, @required this.cancelCallback});

  @override
  _SearchBarState createState() => _SearchBarState();
}

const double _cancelWidth = 60;

class _SearchBarState extends State<SearchBar> {
  FocusNode _focusNode = FocusNode();

  TextEditingController _textEditingController =
      TextEditingController(text: "");
  String _hintText = "";

  bool _isEditing = false;

  double _cancelRight = -_cancelWidth;

  double get _textFieldRight => _cancelWidth + 8 + _cancelRight;

  @override
  void initState() {
    _focusNode.addListener(_onFocusChanged);
    super.initState();
  }

  _onFocusChanged() {
    if (_focusNode.hasFocus) {
      _isEditing = true;
      _onFocus();
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Style.primaryColor,
      padding: EdgeInsets.only(top: 5, bottom: 5),
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
                        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 6),
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.black38,
                        ),
                        border: InputBorder.none,
                        hintText: _hintText),
                    scrollPhysics: NeverScrollableScrollPhysics(),
                    maxLines: 1,
                    controller: _textEditingController,
                    focusNode: _focusNode,
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
                if (_focusNode.hasFocus) {
                  _focusNode.unfocus();
                }
                _onCancel();
                widget.cancelCallback();
              },
            ),
          ),
          AnimatedPositioned(
            onEnd: () {
              if (_isEditing) {
                setState(() {
                  _hintText = "搜索";
                });
              }
            },
            top: 0,
            bottom: 0,
            left: _isEditing
                ? 16
                : (MediaQuery.of(context).size.width - 50) * 0.5,
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
    );
  }

  _onFocus() {
    setState(() {
      _cancelRight = 8;
    });
    widget.beginEdit();
  }

  _onCancel() {
    _textEditingController.text = "";
    _isEditing = false;
    setState(() {
      _hintText = "";
      _cancelRight = -_cancelWidth;
    });
  }
}
