import 'package:flutterwechat/utils/assert_util.dart';

class Constant {
  /// 本地图片资源路径
  static const String assetsImages = 'assets/images/';

  /// 登陆模块相关的资源
  static const String assetsImagesLogin = 'assets/images/login/';

  /// 新特性模块相关的资源
  static const String assetsImagesNewFeature = 'assets/images/new_feature/';

  /// 联系人模块相关的资源
  static const String assetsImagesContacts = 'assets/images/contacts/';

  /// 搜索模块相关的资源
  static const String assetsImagesSearch = 'assets/images/search/';

  /// 缺省页、图片占位符（placeholder）模块相关的资源
  static const String assetsImagesDefault = 'assets/images/default/';

  /// 箭头相关模块相关的资源
  static const String assetsImagesArrow = 'assets/images/arrow/';

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

  /// 我的模块资源
  static const AssertUtil assetsImagesMe = AssertUtil('assets/images/me/');

  /// 微信模块相关的资源
  static const AssertUtil assetsImagesMock = AssertUtil('assets/images/mock/');

  /// TabBar相关模块相关的资源
  static const AssertUtil assetsImagesTabbar =
      AssertUtil('assets/images/tabbar/');

  /// 关于微信相关模块相关的资源
  static const String assetsImagesAboutUs = 'assets/images/about_us/';

  /// 广告相关模块相关的资源
  static const String assetsImagesAds = 'assets/images/ads/';

  /// 背景相关模块相关的资源
  static const String assetsImagesBg = 'assets/images/bg/';

  /// 我模块资源
  static const String assetsImagesProfile = 'assets/images/profile/';

  /// 单选、复选、选中 模块资源
  static const String assetsImagesRadio = 'assets/images/radio/';

  /// 输入框 模块资源
  static const String assetsImagesInput = 'assets/images/input/';

  /// loading 模块资源
  static const String assetsImagesLoading = 'assets/images/loading/';

  /// 朋友圈 模块资源
  static const String assetsImagesMoments = 'assets/images/moments/';

  /// 本地mock数据json
  static const String mockData = 'mock/';

  /// 主边距
  static const double pEdgeInset = 16.0;

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

  /// normalcell的高度
  static const double normalCellHeight = 56;

  // 搜索框高度
  static const double searchBarHeight = 50;
}
