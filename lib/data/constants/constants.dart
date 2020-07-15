import 'package:flutterwechat/ui/components/scroll_behavior.dart';
import 'package:flutterwechat/utils/assert_util.dart';

class Constant {
  /// 微信模块相关的资源
  static const AssertUtil assetsImagesChat = AssertUtil('assets/images/chat/');

  /// 微信聊天输入栏资源
  static const AssertUtil assetsImagesChatBar =
      AssertUtil('assets/images/chat/chat_bar/');

  /// 发现模块资源
  static const AssertUtil assetsImagesDiscover =
      AssertUtil('assets/images/discover/');

  /// 通用模块资源
  static const AssertUtil assetsImagesCommon =
      AssertUtil('assets/images/common/');

  /// 联系人模块相关的资源
  static const AssertUtil assetsImagesContacts =
      AssertUtil('assets/images/contact/');

  /// 我的模块资源
  static const AssertUtil assetsImagesMe = AssertUtil('assets/images/me/');

  static const AssertUtil assetsImagesTest = AssertUtil('assets/images/test/');

  /// 微信模块相关的资源
  static const AssertUtil assetsImagesMock = AssertUtil('assets/images/mock/');

  /// TabBar相关模块相关的资源
  static const AssertUtil assetsImagesTabbar =
      AssertUtil('assets/images/tabbar/');

  /// Tab图标大小
  static const double tabBarIconSize = 30;

  /// 聊天输入栏最小高度
  static const double chatToolbarMinHeight =
      chatToolbarInputViewMinHeight + chatToolbarTopBottomPadding * 2;

  /// 聊天输入栏最大高度
  static const double chatToolbarMaxHeight =
      chatToolbarInputViewMaxHeight + chatToolbarTopBottomPadding * 2;

  /// 聊天输入栏内边距
  static const double chatToolbarTopBottomPadding = 10;

  static const double chatToolbarInputViewMinHeight = 40;
  static const double chatToolbarInputViewMaxHeight = 80;

  /// 列表上的搜索框高度
  static const double listSearchBarHeight = 50;

  /// bootomNavigationBar高度
  static const double bootomNavigationBarHeight = 50;

  /// normalcell的icon大小
  static const double normalCellIconSize = 24;

  // 搜索框高度
  static const double searchBarHeight = 50;

  static const Duration kCommonDuration = Duration(milliseconds: 250);

  // 禁用安卓回弹效果
  static const SameScrollBehavior sameScrollBehavior = SameScrollBehavior();

  // 普通cell最小高度
  static const double kNormalCellMinHeight = 56;
}
