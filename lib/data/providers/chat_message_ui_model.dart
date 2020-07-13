import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/constants.dart';
import 'package:flutterwechat/ui/page/chats/chat_input_type.dart';
import 'package:quiver/iterables.dart';

class ChatMessageUIModel extends ChangeNotifier {
  final ValueChanged<ChatInputType> chatInputTypeChanged;

  // 底部安全区域
  final double _safeBottom;
  final Size _screenSize;

  ChatMessageUIModel({
    this.chatInputTypeChanged,
    MediaQueryData mediaQueryData,
  })  : _safeBottom = mediaQueryData.padding.bottom,
        _screenSize = mediaQueryData.size;

  double keyboardHeight = 0;

  double inputToolHeight = Constant.chatToolbarMinHeight;

  ChatInputType _chatInputType = ChatInputType.none;

  ChatInputType get chatInputType => _chatInputType;

  bool get isShowInputPanel {
    return _chatInputType == ChatInputType.keyboard ||
        _chatInputType == ChatInputType.emoji ||
        _chatInputType == ChatInputType.more;
  }

  double get messageListBottomHeight {
    return this.bottomHeight + inputToolHeight;
  }

  // 更新输入栏高度
  bool setInputToolHeight(double height, {bool notify: true}) {
    var fixHeight = min([
      Constant.chatToolbarMaxHeight,
      max([height, Constant.chatToolbarMinHeight])
    ]);
    fixHeight = fixHeight;
    if (inputToolHeight != fixHeight) {
      inputToolHeight = fixHeight;
      if (notify) {
        notifyListeners();
      }
      return true;
    } else {
      return false;
    }
  }

  double get bottomHeight {
    switch (chatInputType) {
      case ChatInputType.none:
        return _safeBottom;
      case ChatInputType.keyboard:
        return keyboardHeight;
      case ChatInputType.emoji:
        return _screenSize.height / 2;
      case ChatInputType.more:
        return 260 + _safeBottom;
      case ChatInputType.voice:
        return _safeBottom;
      default:
        return 0;
    }
  }

  setKeyboardHeight(double height) {
    keyboardHeight = height;
    notifyListeners();
  }

  setChatInputType(ChatInputType type) {
    if (_chatInputType != type) {
      _chatInputType = type;
      notifyListeners();
      chatInputTypeChanged(type);
    }
  }
}
