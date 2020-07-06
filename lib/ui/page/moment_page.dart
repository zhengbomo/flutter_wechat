import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/shares.dart';
import 'package:flutterwechat/ui/components/avatar.dart';
import 'package:flutterwechat/ui/components/link_button.dart';

class MomentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: Padding(
              padding: EdgeInsets.only(),
              child: ListView.builder(
                itemBuilder: (context, i) {
                  if (i == 0) {
                    return _createHeader();
                  } else {
                    return _createChild();
                  }
                },
                itemCount: 20,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: MediaQuery.of(context).padding.top + kToolbarHeight,
            child: Container(
              // padding:
              // EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Opacity(
                opacity: 1,
                child: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.red.withAlpha(240),
                  title: Text(
                    "朋友圈",
                    style: TextStyle(color: Colors.white),
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createHeader() {
    return Container(
      height: 300,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 30,
            child: Container(
              color: Colors.green,
              height: 300,
            ),
          ),
          Positioned(
            right: 12,
            bottom: 12,
            width: 60,
            height: 60,
            child: Avatar(
              size: 60,
              color: Colors.red,
            ),
          ),
          Positioned(
            right: 12.0 + 60 + 12,
            bottom: 36,
            child: Container(
              child: Text(
                "八戒",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _createChild() {
    return Container(
        margin: EdgeInsets.all(12),
        // color: Shares.randomColor.randomColor(),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Avatar(
                    color: Colors.red,
                    size: 50,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          color: Colors.green,
                          child: LinkButton(
                            child: Text("八戒"),
                            onPressed: () {},
                          ),
                        ),
                        Text("今天晚上吃什么呀今天晚上吃什么呀今天晚上吃什么呀今天晚上吃什么呀今天晚上吃什么呀今天晚上"),
                        Padding(
                          padding: EdgeInsets.only(top: 12, bottom: 12),
                          child: Wrap(
                            children: List.generate(
                              3,
                              (index) => Container(
                                width: 50,
                                height: 50,
                                margin: EdgeInsets.only(right: 8),
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        LinkButton(
                          child: Text("寂静岭"),
                          onPressed: () {},
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(child: Text("4分钟前")),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {},
                            )
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(left: 0, right: 0),
                          color: Colors.white24,
                          child: Column(
                            children: <Widget>[
                              Container(
                                color: Colors.green,
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  color: Colors.red,
                                  child: RichText(
                                    text: TextSpan(text: "", children: [
                                      WidgetSpan(
                                        child: Icon(Icons.favorite, size: 30),
                                      ),
                                      ...List.generate(
                                        10,
                                        (index) => WidgetSpan(
                                          child: LinkButton(
                                            padding: EdgeInsets.only(right: 10),
                                            child: Text("蜗牛骑士"),
                                            onPressed: () {},
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  ...List.generate(
                                    3,
                                    (index) => Container(
                                      margin: EdgeInsets.only(top: 12),
                                      height: 30,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
            ),
          ],
        ));
  }
}
