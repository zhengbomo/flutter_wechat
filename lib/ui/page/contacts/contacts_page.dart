import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterwechat/ui/page/base/auto_keep_alive_state.dart';
import 'package:flutterwechat/ui/page/contacts/contact_list.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends AutoKeepAliveState<ContactsPage> {
  double _appBarTop = 0;
  int _duration = 0;

  double _appBarHeight = 100;
  double _listViewTop = 0;

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
              top: _appBarHeight + _listViewTop,
              bottom: 0,
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: _duration),
              child: ContactList(
                textFieldFocusChanged: (bool value) {},
                dragOffsetChanged: (DragBehavior t1, double offset) {
                  switch (t1) {
                    case DragBehavior.dragStart:
                      setState(() {
                        _duration = 0;
                      });
                      break;
                    case DragBehavior.dragChanging:
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
                        _appBarTop = -0;
                        _listViewTop = _appBarTop;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      _duration = 250;
                      setState(() {
                        _appBarTop = 100;
                        _listViewTop = _appBarTop;
                      });
                    },
                  )
                ],
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
          ]),
        ),
      ),
    );
  }
}
