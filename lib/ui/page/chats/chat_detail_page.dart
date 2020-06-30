import 'package:flutter/material.dart';
import 'package:flutterwechat/data/providers/chat_detail_emoji_model.dart';
import 'package:flutterwechat/data/providers/chat_message_model.dart';
import 'package:flutterwechat/data/providers/chat_message_ui_model.dart';
import 'package:flutterwechat/ui/page/chats/chat_editor.dart';
import 'package:flutterwechat/ui/page/chats/chat_input_type.dart';
import 'package:flutterwechat/ui/page/chats/view/chat_message_container.dart';
import 'package:flutterwechat/ui/page/chats/view/chat_message_text.dart';
import 'package:keyboard_utils/keyboard_utils.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ChatDetailPage extends StatefulWidget {
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final ItemScrollController _scrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  ChatMessageUIModel _chatMessageUIModel;
  ChatMessageModel _chatMessageModel;
  ChatDetailEmojiModel _chatDetailEmojiModel;
  KeyboardUtils _keyboardUtils = KeyboardUtils();

  @override
  void initState() {
    _chatMessageModel = ChatMessageModel();
    _chatDetailEmojiModel = ChatDetailEmojiModel();
    _chatMessageUIModel = ChatMessageUIModel(chatInputTypeChanged: (type) {
      if (type == ChatInputType.more ||
          type == ChatInputType.keyboard ||
          type == ChatInputType.emoji) {
        _scrollToEnd();
      }
    });

    super.initState();
  }

  _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // _scrollController.jumpTo(index: _chatMessageModel.messages.length - 1);
      _scrollController.scrollTo(
          index: _chatMessageModel.messages.length - 1,
          duration: Duration(milliseconds: 250));
    });
  }

  @override
  void dispose() {
    _keyboardUtils.removeAllKeyboardListeners();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => _chatMessageModel,
        ),
        ChangeNotifierProvider(
          create: (_) => _chatMessageUIModel,
        ),
        ChangeNotifierProvider(
          create: (_) => _chatDetailEmojiModel,
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("八戒"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  _scrollToEnd();
                }),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                final indexInfo =
                    _scrollController.getCurrentIndexInfo(wholeVisible: false);
                final int index = indexInfo[0];
                final double offset = indexInfo[1];

                final addCount = 20;
                _chatMessageModel.insertMessage(addCount);
                final realIndex = index + addCount;
                _scrollController.jumpTo(index: realIndex, offset: -offset);
                // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                //   final indexInfo = _scrollController.getCurrentIndexInfo(
                //       wholeVisible: false);
                //   final int index = indexInfo[0];
                //   if (index != realIndex) {
                //     _scrollController.jumpTo(index: realIndex, offset: -offset);
                //   }
                // });
              },
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            _buildMessageList(context),
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              removeBottom: false,
              child: Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ChatEditor(
                  textViewHeightChanged: (init) {
                    if (!init) {
                      _scrollToEnd();
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList(BuildContext context) {
    return Container(
        child: Scrollbar(
            child: Listener(
      onPointerDown: (_) {
        if (_chatMessageUIModel.isShowInputPanel) {
          if (_chatMessageUIModel.chatInputType == ChatInputType.keyboard) {
            FocusScope.of(context).requestFocus(FocusNode());
          }
          _chatMessageUIModel.setChatInputType(ChatInputType.none);
        }
      },
      child: Builder(
        builder: (c) {
          final model = c.watch<ChatMessageModel>();
          final uimodel = c.watch<ChatMessageUIModel>();
          return MediaQuery.removePadding(
              removeBottom: true,
              context: c,
              // onPointerMove: (d) {
              //   print('move');
              // },
              // onPointerDown: (d) {
              //   print('down');
              // },
              // onPointerUp: (d) {
              //   print('up');
              // },
              // onPointerCancel: (d) {
              //   print('cancel');
              // },
              child: ScrollablePositionedList.builder(
                  itemCount: model.messages.length + 1,
                  itemBuilder: (context, i) {
                    if (model.messages.length == i) {
                      // 占位
                      return Container(
                        // color: Colors.green,
                        height: uimodel.messageListBottomHeight,
                      );
                    } else {
                      return Container(
                        // color: model.messages[i].color.withAlpha(150),
                        // height: model.messages[i].height,
                        child: ChatMessageContainer(
                            child: ChatMessageText(message: model.messages[i])),
                      );
                    }
                  },
                  itemScrollController: _scrollController,
                  itemPositionsListener: itemPositionsListener,
                  reverse: false,
                  scrollDirection: Axis.vertical));
        },
      ),
    )));
  }
}
