import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/constants.dart';

class ChatMessageContainer extends StatelessWidget {
  final Widget child;

  ChatMessageContainer({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 12),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(3)),
              ),
            ),
            ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 3),
                      child: Text(
                        "八戒",
                        style: TextStyle(fontSize: 13, color: Colors.black38),
                      ),
                    ),
                    this.child,
                  ],
                )),
            Expanded(
                child:
                    ConstrainedBox(constraints: BoxConstraints(minWidth: 100))),
          ],
        ),
      ),
    );
  }
}
