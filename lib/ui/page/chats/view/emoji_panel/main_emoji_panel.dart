import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/constants.dart';
import 'package:flutterwechat/data/constants/style.dart';
import 'package:flutterwechat/data/providers/chat_detail_emoji_model.dart';
import 'package:flutterwechat/ui/page/chats/view/emoji_panel/emoji_panel_emoji.dart';
import 'package:flutterwechat/ui/page/chats/view/emoji_panel/emoji_panel_favorite.dart';
import 'package:flutterwechat/ui/page/chats/view/emoji_panel/emoji_panel_shop_emoji.dart';
import 'package:flutterwechat/utils/scroll_controller_ext.dart';
import 'package:provider/provider.dart';

class MainEmojiPanel extends StatefulWidget {
  // 动态表情输入
  final ValueChanged<String> emojiInput;

  MainEmojiPanel({
    Key key,
    @required this.emojiInput,
  }) : super(key: key);

  @override
  _MainEmojiPanelState createState() => _MainEmojiPanelState();
}

class _MainEmojiPanelState extends State<MainEmojiPanel> {
  PageController _pageController;
  ScrollController _scrollController;

  int _count = 8;

  @override
  void initState() {
    super.initState();

    final model = context.read<ChatDetailEmojiModel>();
    _pageController = PageController(initialPage: model.index);
    _scrollController = ScrollController(initialScrollOffset: model.offset);

    _scrollController.addListener(() {
      model.offset = _scrollController.offset;
    });
    _pageController.addListener(() {
      final newIndex = _pageController.page.round();
      if (newIndex != model.index) {
        model.setIndex(newIndex);

        var newOffset = 50.0 * newIndex;
        _scrollController.scrollToCenter(
            offset: newOffset,
            duration: Constant.kCommonDuration,
            curve: Curves.easeInOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 50,
          color: Style.chatToolbarBackgroundColor,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) {
              switch (i) {
                case 0:
                  return SizedBox(
                    width: 50,
                    height: 50,
                    child: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        print("ADD");
                      },
                    ),
                  );
                default:
                  return SizedBox(
                    width: 50,
                    height: 50,
                    child: IconButton(
                      onPressed: () {
                        _pageController.jumpToPage(i - 1);
                      },
                      color:
                          (context.watch<ChatDetailEmojiModel>().index == i - 1)
                              ? Colors.red
                              : Colors.black54,
                      icon: Icon(Icons.check_circle_outline),
                    ),
                  );
              }
            },
            itemCount: 1 + _count,
          ),
        ),
        Expanded(
          child: Container(
            color: Color(0xffe9e9e9),
            child: PageView.builder(
              controller: _pageController,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return EmojiPanelEmoji();
                  case 1:
                    return EmojiPanelFavorite();
                  default:
                    return EmojiPanelShopEmoji();
                }
              },
              itemCount: _count,
            ),
          ),
        )
      ],
    );
  }
}
