import 'package:flutter/material.dart';
import 'package:flutterwechat/data/providers/chat_detail_emoji_model.dart';
import 'package:flutterwechat/data/providers/chat_message_model.dart';
import 'package:flutterwechat/data/providers/chat_message_ui_model.dart';
import 'package:flutterwechat/ui/page/chats/chat_input_type.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final ItemScrollController _scrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  ChatMessageUIModel _chatMessageUIModel;
  ChatMessageModel _chatMessageModel;
  ChatDetailEmojiModel _chatDetailEmojiModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // _scrollToEnd(animated: false);
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_chatMessageModel == null) {
      MediaQuery query =
          context.getElementForInheritedWidgetOfExactType<MediaQuery>().widget;

      _chatMessageModel = ChatMessageModel();
      _chatDetailEmojiModel = ChatDetailEmojiModel();
      _chatMessageUIModel = ChatMessageUIModel(
        mediaQueryData: query.data,
        chatInputTypeChanged: (type) {
          if (type == ChatInputType.more ||
              type == ChatInputType.keyboard ||
              type == ChatInputType.emoji) {
            _scrollToEnd();
          }
        },
      );
    }
    super.didChangeDependencies();
  }

  _scrollToEnd({bool animated = true}) {
    return;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // _scrollController.jumpTo(index: _chatMessageModel.messages.length - 1);
      if (animated) {
        _scrollController.scrollTo(
          index: _chatMessageModel.messages.length - 1,
          duration: Duration(milliseconds: 250),
          offset: -500,
        );
      } else {
        _scrollController.jumpTo(
          index: _chatMessageModel.messages.length - 1,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _chatMessageModel),
        ChangeNotifierProvider.value(value: _chatMessageUIModel),
        ChangeNotifierProvider.value(value: _chatDetailEmojiModel),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Center(
            child: TextField(),
          ),
        ),
      ),
    );
  }
}
