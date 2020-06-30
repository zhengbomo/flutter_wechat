import 'package:flutter/material.dart';

class EmojiPanelEmoji extends StatefulWidget {
  @override
  _EmojiPanelEmojiState createState() => _EmojiPanelEmojiState();
}

class _EmojiPanelEmojiState extends State<EmojiPanelEmoji> {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: CustomScrollView(slivers: <Widget>[
      SliverList(
        delegate: SliverChildListDelegate(
          [
            Padding(
                padding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                child: Text("最近使用")),
          ],
        ),
      ),
      SliverGrid(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return IconButton(
                onPressed: () {
                  print("😁");
                },
                icon: Icon(Icons.account_circle,
                    size: 40, color: Colors.orangeAccent));
          },
          childCount: 4,
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate(
          [
            Padding(
                padding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                child: Text("所有表情")),
          ],
        ),
      ),
      SliverSafeArea(
        sliver: SliverGrid(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Icon(Icons.account_circle,
                  size: 40, color: Colors.orangeAccent);
            },
            childCount: 70,
          ),
        ),
      )
    ]));
  }
}
