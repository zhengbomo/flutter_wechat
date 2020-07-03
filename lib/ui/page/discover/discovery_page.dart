import 'package:flutter/material.dart';
import 'package:flutterwechat/ui/page/base/auto_keep_alive_state.dart';
import 'package:flutterwechat/ui/page/discover/moment_list_page.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends AutoKeepAliveState<DiscoverPage> {
  ScrollController _controller = ScrollController();

  double _listPadding = 0;

  bool _isRelease = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("发现"),
      ),
      body: Column(
        children: <Widget>[
          FlatButton(
            child: Text("push"),
            onPressed: () {
              setState(() {
                _listPadding = 0;
              });
              return;
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return MomentListPage();
              }));
            },
          ),
          Expanded(
              child: NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    if (notification is ScrollUpdateNotification) {
                      if (notification.dragDetails == null) {
                        _isRelease = true;
                      }
                      // 释放
                      if (_isRelease) {
                        _isRelease = false;
                        // _controller.jumpTo(0);
                        setState(() {
                          _listPadding = 300;
                        });
                      }
                    }
                    return false;
                  },
                  child: AnimatedContainer(
                    margin: EdgeInsets.fromLTRB(0, _listPadding, 0, 0),
                    curve: Curves.easeInOut,
                    duration: Duration(milliseconds: 300),
                    child: Scrollbar(
                      child: ListView.builder(
                          controller: _controller,
                          itemBuilder: (context, i) {
                            return Container(
                              color: Colors.green,
                              margin: EdgeInsets.all(8),
                              height: 80,
                            );
                          },
                          itemCount: 100),
                    ),
                  )))
        ],
      ),
    );
  }
}
