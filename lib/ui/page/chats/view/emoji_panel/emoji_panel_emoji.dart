import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterwechat/ui/page/chats/chat_editor.dart';

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
                context.read<ChatEditorModel>().addInput("[捂脸]");
              },
              icon: Icon(
                Icons.account_circle,
                size: 30,
                color: Colors.orangeAccent,
              ),
            );
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
              return IconButton(
                onPressed: () {
                  context.read<ChatEditorModel>().addInput("😁");
                },
                icon: Icon(
                  Icons.account_circle,
                  size: 30,
                  color: Colors.orangeAccent,
                ),
              );
            },
            childCount: 70,
          ),
        ),
      )
    ]));
  }
}
