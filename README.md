# 仿微信交互

学习flutter有一段时间了，本项目主要针对微信的复杂交互页面进行实现，主要包含

1. TabBar
   * 显示/隐藏
   * Badge
2. 消息主页
   * SearchBar的交互
   * 下拉显示小程序
   * AddMenu交互
   * TabBar处理
3. 联系人主页
   * SearchBar交互
   * 分组展示
4. 消息详情页
   * ChatBar工具栏
   * 向上加载数据，并保留当前位置
   * scrollToEnd
5. 朋友圈页面
    * AppBar渐变处理
    * 评论滚动到特定位置
    * 评论框交互
6. 我的页面
   * 下拉展示拍视频动态

## 演示

![聊天页面](https://github.com/zhengbomo/flutter_wechat/blob/master/images/wechat_chat-min.gif?raw=true)
![联系人页面](https://github.com/zhengbomo/flutter_wechat/blob/master/images/wechat_contact-min.gif?raw=true)
![主页](https://github.com/zhengbomo/flutter_wechat/blob/master/images/wechat_home-min.gif?raw=true)
![我的页面](https://github.com/zhengbomo/flutter_wechat/blob/master/images/wechat_me-min.gif?raw=true)
![朋友圈页面](https://github.com/zhengbomo/flutter_wechat/blob/master/images/wechat_moment-min.gif?raw=true)
![安卓demo](https://github.com/zhengbomo/flutter_wechat/blob/master/images/wechat_android-min.gif?raw=true)

## 问题

### iOS在RichText使用WidgetSpan和gesture会报下面问题，而Android没有该问题

```txt
RangeError (index): Invalid value: Valid value range is empty: 0
```

这个问题在flutter 1.20 pre版本得到解决
[](https://github.com/flutter/flutter/issues/51936#issuecomment-658662209)

## 文章

* [flutter仿微信聊天交互](https://blog.bombox.org/2020-06-30/flutter-chat-listview/)

## TODO

* 扫一扫
* 语音输入交互
* 图片选择
* 优化代码结构
* 性能优化
