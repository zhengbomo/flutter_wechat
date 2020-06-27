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
              child: Image.asset(Constant.assetsImagesMock.named("glory_of_kings.png"), width: 50, height: 50),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 200),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(3)
                ),
                child: this.child,
              ),
            ),
            Expanded(child: ConstrainedBox(constraints: BoxConstraints(minWidth: 100))),
          ],
        ),
      ),
    );
  }
}