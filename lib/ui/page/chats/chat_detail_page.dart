import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterwechat/data/constants/constants.dart';
import 'package:flutterwechat/data/providers/chat_detail_emoji_model.dart';
import 'package:flutterwechat/data/providers/chat_message_model.dart';
import 'package:flutterwechat/data/providers/chat_message_ui_model.dart';
import 'package:flutterwechat/ui/components/child_builder.dart';
import 'package:flutterwechat/ui/page/chats/chat_editor.dart';
import 'package:flutterwechat/ui/page/chats/chat_input_type.dart';
import 'package:flutterwechat/ui/page/chats/view/chat_message_container.dart';
import 'package:flutterwechat/ui/page/chats/view/chat_message_text.dart';
import 'package:flutterwechat/ui/view/bm_appbar.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutterwechat/utils/build_context_read.dart';

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

  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    // 滚动到最后
    _scrollToEnd(animated: false);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_chatMessageModel == null) {
      MediaQuery query = context.getInheritedWidget<MediaQuery>();
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
    print("main build");
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
                // 加载更早的数据
                final indexInfo =
                    _scrollController.getCurrentIndexInfo(wholeVisible: false);
                final int index = indexInfo[0];
                final double offset = indexInfo[1];

                final addCount = 20;
                _chatMessageModel.insertMessage(addCount);
                final realIndex = index + addCount;
                _scrollController.jumpTo(index: realIndex, offset: -offset);
              },
            )
          ],
        ),
        body: ChildBuilder2(
          // content
          child2: GestureDetector(
            onPanDown: (_) {
              if (_chatMessageUIModel.isShowInputPanel) {
                if (_chatMessageUIModel.chatInputType ==
                    ChatInputType.keyboard) {
                  _focusNode.unfocus();
                }
                _chatMessageUIModel.setChatInputType(ChatInputType.none);
              }
            },
            child: Scrollbar(
              child: Builder(builder: (c) {
                // 关联变化
                c.select((ChatMessageModel model) => model.messageChangedId);
                final model = _chatMessageModel;

                return ScrollablePositionedList.builder(
                  itemCount: model.messages.length + 1,
                  itemBuilder: (context, i) {
                    if (model.messages.length == i) {
                      return Builder(builder: (context) {
                        final messageListBottomHeight = context.select(
                            (ChatMessageUIModel model) =>
                                model.messageListBottomHeight);
                        // 占位
                        return SizedBox(height: messageListBottomHeight);
                      });
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
              }),
            ),
          ),
          // chatbar
          child1: ChatEditor(
            focusNode: _focusNode,
            textViewHeightChanged: (init) {
              if (!init) {
                _scrollToEnd();
              }
            },
          ),
          builder: (context, child1, child2) {
            return Stack(
              children: <Widget>[
                MediaQuery.removePadding(
                  removeBottom: true,
                  context: context,
                  child: child2,
                ),
                MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  removeBottom: false,
                  child: Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: child1,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
