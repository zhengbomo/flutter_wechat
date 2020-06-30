import 'package:flutter/material.dart';

class EmojiPanelShopEmoji extends StatefulWidget {
  @override
  _EmojiPanelShopEmojiState createState() => _EmojiPanelShopEmojiState();
}

class _EmojiPanelShopEmojiState extends State<EmojiPanelShopEmoji> {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: CustomScrollView(slivers: <Widget>[
      SliverList(
        delegate: SliverChildListDelegate(
          [
            Theme(
                data: ThemeData(
                    buttonTheme: ButtonThemeData(
                        splashColor: Colors.transparent,
                        height: 30,
                        highlightColor: Colors.transparent)),
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 40,
                    ),
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Text("猪小屁生活篇"),
                            ),
                            FlatButton(
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.green,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    child: Text("震惊文化"),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 12,
                                  )
                                ],
                              ),
                              onPressed: () {
                                print("link");
                              },
                            )
                          ],
                        ))))
          ],
        ),
      ),
      SliverSafeArea(
        sliver: SliverGrid(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Padding(
                  padding: EdgeInsets.all(12),
                  child: FlatButton(
                      color: Colors.black12,
                      onPressed: () {
                        print("😁");
                      },
                      child: Icon(Icons.image,
                          size: 40, color: Colors.orangeAccent)));
            },
            childCount: 34,
          ),
        ),
      ),
    ]));
  }
}
