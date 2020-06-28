import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutterwechat/data/providers/chat_message_model.dart';
import 'package:flutterwechat/data/providers/chat_message_ui_model.dart';
import 'package:flutterwechat/ui/page/chats/chat_editor.dart';
import 'package:flutterwechat/ui/page/chats/chat_input_type.dart';
import 'package:flutterwechat/ui/page/chats/view/chat_message_container.dart';
import 'package:flutterwechat/ui/page/chats/view/chat_message_text.dart';
import 'package:flutterwechat/utils/vender/scroll_to_index_with_offset/lib/scroll_to_index.dart';
import 'package:keyboard_utils/keyboard_utils.dart';
import 'package:provider/provider.dart';

class ChatDetailPage extends StatefulWidget {
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  AutoScrollController _scrollController;
  ChatMessageUIModel _chatMessageUIModel;
  ChatMessageModel _chatMessageModel;
  KeyboardUtils _keyboardUtils = KeyboardUtils();
  @override
  void initState() {
    _chatMessageModel = ChatMessageModel();
    _chatMessageUIModel = ChatMessageUIModel(chatInputTypeChanged: (type) {
      if (type == ChatInputType.more ||
          type == ChatInputType.keyboard ||
          type == ChatInputType.emoji) {
        _scrollToEnd();
      }
    });
    _scrollController = AutoScrollController(
      viewportBoundaryGetter: () => Rect.zero,
      axis: Axis.vertical,
      // suggestedRowHeight: 100
    );

    super.initState();
  }

  _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.scrollToIndex(_chatMessageModel.messages.length,
          preferPosition: AutoScrollPosition.end, offset: 0);
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
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("傻姑1005"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {},
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            _buildMessageList(context),
            MediaQuery.removePadding(
              context: context,
              removeBottom: true,
              child: Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ChatEditor(
                  textViewHeightChanged: (_) {
                    _scrollToEnd();
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
          var model = c.watch<ChatMessageModel>();
          return ListView.builder(
              padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
              dragStartBehavior: DragStartBehavior.start,
              controller: _scrollController,
              itemBuilder: (c, i) {
                if (model.messages.length == i) {
                  // 占位
                  return AutoScrollTag(
                      key: ValueKey(i),
                      controller: _scrollController,
                      index: i,
                      child: Container(
                        height: c
                            .watch<ChatMessageUIModel>()
                            .messageListBottomHeight,
                        // color: Colors.red,
                      ));
                } else {
                  return AutoScrollTag(
                    key: ValueKey(i),
                    controller: _scrollController,
                    index: i,
                    child: ChatMessageContainer(
                        child: ChatMessageText(message: model.messages[i])),
                  );
                }
              },
              itemCount: model.messages.length + 1);
        },
      ),
    )));
  }
}
