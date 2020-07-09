import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterwechat/data/constants/constants.dart';
import 'package:flutterwechat/data/providers/chat_detail_emoji_model.dart';
import 'package:flutterwechat/data/providers/chat_message_model.dart';
import 'package:flutterwechat/data/providers/chat_message_ui_model.dart';
import 'package:flutterwechat/ui/page/chats/chat_editor.dart';
import 'package:flutterwechat/ui/page/chats/chat_input_type.dart';
import 'package:flutterwechat/ui/page/chats/view/chat_message_container.dart';
import 'package:flutterwechat/ui/page/chats/view/chat_message_text.dart';
import 'package:flutterwechat/ui/view/bm_appbar.dart';
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

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollToEnd(animated: false);
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
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
        appBar: BMAppBar(
          elevation: 1,
          title: Text("八戒"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                // 发送数据
                _chatMessageModel.addMessage(1);
                _scrollToEnd();
              },
            ),
            IconButton(
              icon: SvgPicture.asset(
                  Constant.assetsImagesChat.named("icons_filled_more.svg")),
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
        body: Builder(builder: (context) {
          return Stack(
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
          );
        }),
      ),
    );
  }

  Widget _buildMessageList(BuildContext context) {
    return Container(
        child: Scrollbar(
            child: Listener(
      onPointerDown: (_) {
        final model = context.read<ChatMessageUIModel>();
        if (model.isShowInputPanel) {
          if (model.chatInputType == ChatInputType.keyboard) {
            FocusScope.of(context).requestFocus(FocusNode());
          }
          model.setChatInputType(ChatInputType.none);
        }
      },
      child: Builder(
        builder: (c) {
          return MediaQuery.removePadding(
            removeBottom: true,
            context: c,
            child: Builder(
              builder: (c) {
                final model = c.watch<ChatMessageModel>();
                final messageListBottomHeight = c.select(
                    (ChatMessageUIModel model) =>
                        model.messageListBottomHeight);

                return ScrollablePositionedList.builder(
                  itemCount: model.messages.length + 1,
                  itemBuilder: (context, i) {
                    if (model.messages.length == i) {
                      // 占位
                      return SizedBox(height: messageListBottomHeight);
                    } else {
                      return ChatMessageContainer(
                        showUsername: false,
                        message: model.messages[i],
                        child: ChatMessageText(message: model.messages[i]),
                      );
                    }
                  },
                  itemScrollController: _scrollController,
                  itemPositionsListener: itemPositionsListener,
                  reverse: false,
                  scrollDirection: Axis.vertical,
                );
              },
            ),
          );
        },
      ),
    )));
  }
}
