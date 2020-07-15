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
  final FocusNode focusNode;
  final ValueChanged<bool> textViewHeightChanged;

  final ValueChanged<String> emojiInput;

  ChatEditor({this.textViewHeightChanged, this.focusNode, this.emojiInput});

  @override
  _ChatEditorState createState() => _ChatEditorState();
}

class _ChatEditorState extends State<ChatEditor>
    with SingleTickerProviderStateMixin {
  KeyboardUtils _keyboardUtils = KeyboardUtils();
  int _subscribingId;

  GlobalKey _globalKey = GlobalKey();

  ChatMessageUIModel _uimodel;

  @override
  void initState() {
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
    _keyboardUtils.unsubscribeListener(subscribingId: _subscribingId);
    super.dispose();
  }

  GlobalKey _textFieldKey = GlobalKey();
  ChatEditorModel _chatEditorModel =
      ChatEditorModel(text: "mmmmmmmmmmmmmmmmmmmmmmmmmmmm");

  @override
  Widget build(BuildContext context) {
    print("chat editor build");
    final topBottomPadding = Constant.chatToolbarTopBottomPadding;
    return Provider.value(
      value: _chatEditorModel,
      child: ColoredBox(
        color: Style.chatToolbarBackgroundColor,
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
                            widget.focusNode.unfocus();
                          }
                          model.setInputToolHeight(
                              Constant.chatToolbarMinHeight);
                          model.setChatInputType(ChatInputType.voice);
                        } else {
                          widget.focusNode.requestFocus();
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
                              minHeight:
                                  Constant.chatToolbarInputViewMinHeight),
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
                                      scrollController:
                                          _chatEditorModel.textScrollController,
                                      style: TextStyle(fontSize: 18),
                                      // expands: true,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 3,
                                      minLines: 1,
                                      focusNode: widget.focusNode,
                                      placeholder: "ddd",
                                      controller:
                                          _chatEditorModel.editingController,
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
                                      child: GestureDetector(
                                        onPanDown: (data) {
                                          print("start");
                                        },
                                        onPanEnd: (data) {
                                          print("end");
                                        },
                                        child: FlatButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          color: Colors.white,
                                          onPressed: () {},
                                          child: Text(
                                            "按住说话",
                                            style: TextStyle(
                                                color: Color(0xff181818)),
                                          ),
                                        ),
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
                            widget.focusNode.requestFocus();
                          } else {
                            if (model.chatInputType == ChatInputType.keyboard) {
                              widget.focusNode.unfocus();
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
                          widget.focusNode.requestFocus();
                        } else {
                          if (model.chatInputType == ChatInputType.keyboard) {
                            widget.focusNode.unfocus();
                          }
                          _updateTextToolHeight(model);
                          model.setChatInputType(ChatInputType.more);
                        }
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
              duration: Constant.kCommonDuration,
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
                    child = MainEmojiPanel(
                      key: emojiPanelKey,
                      emojiInput: (String value) {
                        // 动态表情输入
                      },
                    );
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
      height += (2 * Constant.chatToolbarTopBottomPadding);
      var model = _uimodel;
      if (height != model.inputToolHeight) {
        print("textHeight changed");
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

class ChatEditorModel {
  final TextEditingController editingController;

  ChatEditorModel({String text = ""})
      : editingController = TextEditingController(text: text);

  ScrollController textScrollController = ScrollController();
  deleteInput() {
    final text = editingController.text;
    if (text.length > 0) {
      editingController.text = text.substring(0, text.length - 2);
    }
  }

  addInput(String input) {
    editingController.text += input;

    textScrollController.animateTo(
      textScrollController.position.maxScrollExtent,
      duration: Constant.kCommonDuration,
      curve: Curves.easeInOut,
    );
  }
}
