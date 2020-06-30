import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/constants.dart';
import 'package:flutterwechat/data/constants/style.dart';
import 'package:flutterwechat/data/providers/chat_detail_emoji_model.dart';
import 'package:flutterwechat/data/providers/chat_message_ui_model.dart';
import 'package:flutterwechat/ui/page/chats/chat_input_type.dart';
import 'package:flutterwechat/ui/page/chats/view/emoji_panel/main_emoji_panel.dart';
import 'package:flutterwechat/ui/page/chats/view/more_panel.dart';
import 'package:flutterwechat/ui/view/svg_icon_buttton.dart';
import 'package:keyboard_utils/keyboard_listener.dart';
import 'package:keyboard_utils/keyboard_utils.dart';
import 'package:provider/provider.dart';

class ChatEditor extends StatefulWidget {
  final ValueChanged<bool> textViewHeightChanged;

  ChatEditor({this.textViewHeightChanged});

  @override
  _ChatEditorState createState() => _ChatEditorState();
}

class _ChatEditorState extends State<ChatEditor>
    with SingleTickerProviderStateMixin {
  FocusNode _focusNode = FocusNode();
  TextEditingController _editingController;
  KeyboardUtils _keyboardUtils = KeyboardUtils();
  int _subscribingId;

  GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    _editingController = TextEditingController(text: "mmmmmmmmmmmmmmmmmm");
    _subscribingId = _keyboardUtils.add(
        listener: KeyboardListener(willShowKeyboard: (height) {
      var model = context.read<ChatMessageUIModel>();
      model.keyboardHeight = height;
      // 更新toolheight
      _updateTextToolHeight(model);
      model.setChatInputType(ChatInputType.keyboard);
    }, willHideKeyboard: () {
      var model = context.read<ChatMessageUIModel>();
      model.keyboardHeight = 0;
      if (model.chatInputType == ChatInputType.keyboard) {
        model.setChatInputType(ChatInputType.none);
      }
    }));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var model = context.read<ChatMessageUIModel>();
      _updateTextToolHeight(model, notify: true);
      widget.textViewHeightChanged(true);
    });

    super.initState();
  }

  _updateTextToolHeight(ChatMessageUIModel model, {bool notify: false}) {
    // 更新toolheight
    var textViewHeight =
        _textFieldKey.currentContext.findRenderObject().paintBounds.size.height;

    textViewHeight += (Constant.chatToolbarTopBottomPadding * 2);
    if (textViewHeight != model.inputToolHeight) {
      model.setInputToolHeight(textViewHeight, notify: notify);
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _keyboardUtils.unsubscribeListener(subscribingId: _subscribingId);
    super.dispose();
  }

  GlobalKey _textFieldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
        color: Style.chatToolbarBackgroundColor.withAlpha(255),
        // color: Colors.green.withAlpha(150),
        child: SafeArea(
            top: false,
            bottom: false,
            child: Column(
              children: <Widget>[
                Padding(
                  key: _globalKey,
                  padding: EdgeInsets.fromLTRB(
                      5,
                      Constant.chatToolbarTopBottomPadding,
                      5,
                      Constant.chatToolbarTopBottomPadding),
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        _IconButton(
                          onPressed: () {
                            var model = context.read<ChatMessageUIModel>();
                            if (model.chatInputType != ChatInputType.voice) {
                              if (model.chatInputType ==
                                  ChatInputType.keyboard) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              }
                              model.setInputToolHeight(
                                  Constant.chatToolbarMinHeight);
                              model.setChatInputType(ChatInputType.voice);
                            } else {
                              _focusNode.requestFocus();
                              // model.setChatInputType(ChatInpuqtType.keyboard);
                            }
                          },
                          assetName: context
                                      .watch<ChatMessageUIModel>()
                                      .chatInputType ==
                                  ChatInputType.voice
                              ? Constant.assetsImagesChatBar
                                  .named("chat_bar_voice.svg")
                              : Constant.assetsImagesChatBar
                                  .named("chat_bar_keyboard.svg"),
                        ),
                        Expanded(
                            child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxHeight:
                                        Constant.chatToolbarInputViewMaxHeight,
                                    minHeight:
                                        Constant.chatToolbarInputViewMinHeight),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Offstage(
                                        offstage: context
                                                .watch<ChatMessageUIModel>()
                                                .chatInputType ==
                                            ChatInputType.voice,
                                        child: CupertinoTextField(
                                          key: _textFieldKey,
                                          style: TextStyle(fontSize: 18),
                                          // expands: true,
                                          keyboardType: TextInputType.multiline,
                                          maxLines: 3,
                                          minLines: 1,
                                          focusNode: _focusNode,
                                          placeholder: "ddd",
                                          controller: _editingController,
                                          onChanged: (text) {
                                            _onTextChanged(context);
                                          },
                                        )),
                                    Offstage(
                                      offstage: context
                                              .watch<ChatMessageUIModel>()
                                              .chatInputType !=
                                          ChatInputType.voice,
                                      child: SizedBox(
                                        height: 40,
                                        child: FlatButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          color: Colors.white,
                                          onPressed: () {},
                                          child: Text("按住说话",
                                              style: TextStyle(
                                                  color: Color(0xff181818))),
                                        ),
                                      ),
                                    )
                                  ],
                                ))),
                        Padding(
                          padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                          child: _IconButton(
                            onPressed: () {
                              var model = context.read<ChatMessageUIModel>();
                              if (model.chatInputType ==
                                  ChatInputType.keyboard) {
                                _focusNode.unfocus();
                              }
                              _updateTextToolHeight(model);
                              model.setChatInputType(ChatInputType.emoji);
                            },
                            assetName: Constant.assetsImagesChatBar
                                .named("chat_bar_emoji.svg"),
                          ),
                        ),
                        _IconButton(
                          onPressed: () {
                            var model = context.read<ChatMessageUIModel>();
                            if (model.chatInputType == ChatInputType.keyboard) {
                              _focusNode.unfocus();
                            }
                            _updateTextToolHeight(model);
                            model.setChatInputType(ChatInputType.more);
                          },
                          assetName: Constant.assetsImagesChatBar
                              .named("chat_bar_more.svg"),
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedSize(
                  curve: Curves.easeInOut,
                  duration: Duration(milliseconds: 250),
                  vsync: this,
                  child: SizedBox(
                    height: context.watch<ChatMessageUIModel>().bottomHeight,
                    child: Builder(builder: (context) {
                      var chatType =
                          context.watch<ChatMessageUIModel>().chatInputType;
                      switch (chatType) {
                        case ChatInputType.none:
                        case ChatInputType.voice:
                        case ChatInputType.keyboard:
                          return Container();
                        case ChatInputType.emoji:
                          return MainEmojiPanel(key: emojiPanelKey);
                        case ChatInputType.more:
                          return MorePanel();
                        default:
                          return Container();
                      }
                    }),
                  ),
                ),
              ],
            )));
  }

  GlobalKey emojiPanelKey = GlobalKey();

  _onTextChanged(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var height = _textFieldKey.currentContext
          .findRenderObject()
          .paintBounds
          .size
          .height;
      var height2 = _textFieldKey.currentContext
          .findRenderObject()
          .paintBounds
          .size
          .height;
      print("$height, $height2");
      height += (2 * Constant.chatToolbarTopBottomPadding);
      var model = context.read<ChatMessageUIModel>();
      if (height != model.inputToolHeight) {
        // scroll to end
        if (model.setInputToolHeight(height)) {
          widget.textViewHeightChanged(false);
        }
      }
    });
  }
}

class _IconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String assetName;

  _IconButton({this.onPressed, this.assetName});
  @override
  Widget build(BuildContext context) {
    return SvgIconButton(
      maxSize: Size(Constant.chatToolbarInputViewMinHeight,
          Constant.chatToolbarInputViewMinHeight),
      onPressed: onPressed,
      iconSize: 30,
      color: Color(0xff181818),
      assetName: assetName,
    );
  }
}
