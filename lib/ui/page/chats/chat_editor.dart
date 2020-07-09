import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/constants.dart';
import 'package:flutterwechat/data/constants/style.dart';
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

  ChatMessageUIModel _uimodel;

  @override
  void initState() {
    _editingController =
        TextEditingController(text: "mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
    _subscribingId = _keyboardUtils.add(
        listener: KeyboardListener(willShowKeyboard: (height) {
      _uimodel.keyboardHeight = height;
      // 更新toolheight
      _updateTextToolHeight(_uimodel);
      _uimodel.setChatInputType(ChatInputType.keyboard);
    }, willHideKeyboard: () {
      _uimodel.keyboardHeight = 0;
      if (_uimodel.chatInputType == ChatInputType.keyboard) {
        _uimodel.setChatInputType(ChatInputType.none);
      }
    }));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _updateTextToolHeight(_uimodel, notify: true);
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
    final topBottomPadding = Constant.chatToolbarTopBottomPadding;
    return ColoredBox(
      color: Style.chatToolbarBackgroundColor,
      // color: Colors.green.withAlpha(150),
      child: Column(
        children: <Widget>[
          Padding(
            key: _globalKey,
            padding:
                EdgeInsets.fromLTRB(5, topBottomPadding, 5, topBottomPadding),
            child: Container(
              child: Row(
                children: <Widget>[
                  _IconButton(
                    onPressed: () {
                      var model = _uimodel;
                      if (model.chatInputType != ChatInputType.voice) {
                        if (model.chatInputType == ChatInputType.keyboard) {
                          FocusScope.of(context).requestFocus(FocusNode());
                        }
                        model.setInputToolHeight(Constant.chatToolbarMinHeight);
                        model.setChatInputType(ChatInputType.voice);
                      } else {
                        _focusNode.requestFocus();
                      }
                    },
                    assetName: context.select((ChatMessageUIModel model) =>
                                model.chatInputType) ==
                            ChatInputType.voice
                        ? Constant.assetsImagesChatBar
                            .named("chat_bar_keyboard.svg")
                        : Constant.assetsImagesChatBar
                            .named("chat_bar_voice.svg"),
                  ),
                  Expanded(
                    child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxHeight: Constant.chatToolbarInputViewMaxHeight,
                            minHeight: Constant.chatToolbarInputViewMinHeight),
                        child: Builder(
                          builder: (context) {
                            final chatInputType = context.select(
                                (ChatMessageUIModel model) =>
                                    model.chatInputType);
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Offstage(
                                  offstage:
                                      chatInputType == ChatInputType.voice,
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
                                  ),
                                ),
                                Offstage(
                                  offstage:
                                      chatInputType != ChatInputType.voice,
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
                                ),
                              ],
                            );
                          },
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                    child: _IconButton(
                      onPressed: () {
                        var model = _uimodel;
                        if (model.chatInputType == ChatInputType.emoji) {
                          _focusNode.requestFocus();
                        } else {
                          if (model.chatInputType == ChatInputType.keyboard) {
                            _focusNode.unfocus();
                          }
                          _updateTextToolHeight(model);
                          model.setChatInputType(ChatInputType.emoji);
                        }
                      },
                      assetName: context.select((ChatMessageUIModel model) =>
                                  model.chatInputType) ==
                              ChatInputType.emoji
                          ? Constant.assetsImagesChatBar
                              .named("chat_bar_keyboard.svg")
                          : Constant.assetsImagesChatBar
                              .named("chat_bar_emoji.svg"),
                    ),
                  ),
                  _IconButton(
                    onPressed: () {
                      var model = _uimodel;
                      if (model.chatInputType == ChatInputType.more) {
                        _focusNode.requestFocus();
                      } else {
                        if (model.chatInputType == ChatInputType.keyboard) {
                          _focusNode.unfocus();
                        }
                        _updateTextToolHeight(model);
                        model.setChatInputType(ChatInputType.more);
                      }
                    },
                    assetName:
                        Constant.assetsImagesChatBar.named("chat_bar_more.svg"),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: 250),
            vsync: this,
            child: Builder(builder: (context) {
              var chatType = context
                  .select((ChatMessageUIModel model) => model.chatInputType);
              var model = _uimodel;
              final bottomHeight = model.bottomHeight;
              Widget child;
              switch (chatType) {
                case ChatInputType.none:
                case ChatInputType.voice:
                case ChatInputType.keyboard:
                  child = Container();
                  break;
                case ChatInputType.emoji:
                  child = MainEmojiPanel(key: emojiPanelKey);
                  break;
                case ChatInputType.more:
                  child = MorePanel();
                  break;
                default:
                  child = Container();
                  break;
              }
              return SizedBox(
                height: bottomHeight,
                child: child,
              );
            }),
          ),
        ],
      ),
    );
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
      var model = _uimodel;
      if (height != model.inputToolHeight) {
        // scroll to end
        if (model.setInputToolHeight(height)) {
          widget.textViewHeightChanged(false);
        }
      }
    });
  }

  @override
  void didChangeDependencies() {
    if (_uimodel == null) {
      _uimodel = context.read<ChatMessageUIModel>();
    }
    super.didChangeDependencies();
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
