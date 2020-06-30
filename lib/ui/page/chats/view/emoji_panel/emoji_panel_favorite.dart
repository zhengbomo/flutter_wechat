import 'package:flutter/material.dart';

class EmojiPanelFavorite extends StatefulWidget {
  @override
  _EmojiPanelFavoriteState createState() => _EmojiPanelFavoriteState();
}

class _EmojiPanelFavoriteState extends State<EmojiPanelFavorite> {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: CustomScrollView(slivers: <Widget>[
      SliverList(
        delegate: SliverChildListDelegate(
          [
            Padding(
                padding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                child: Text("添加的单个表情")),
          ],
        ),
      ),
      SliverSafeArea(
        sliver: SliverGrid(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              if (index == 0) {
                return Padding(
                    padding: EdgeInsets.all(12),
                    child: FlatButton(
                        color: Colors.black12,
                        onPressed: () {
                          print("😁");
                        },
                        child:
                            Icon(Icons.add, size: 40, color: Colors.black38)));
              } else {
                return Padding(
                    padding: EdgeInsets.all(12),
                    child: FlatButton(
                        color: Colors.black12,
                        onPressed: () {
                          print("😁");
                        },
                        child: Icon(Icons.image,
                            size: 40, color: Colors.orangeAccent)));
              }
            },
            childCount: 1 + 34,
          ),
        ),
      ),
    ]));
  }
}
