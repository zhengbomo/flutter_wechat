import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterwechat/data/constants/constants.dart';

class AddMenu extends StatefulWidget {
  final bool show;

  final VoidCallback dismissCall;

  AddMenu({@required this.dismissCall, @required this.show});

  @override
  _AddMenuState createState() => _AddMenuState();
}

class _AddMenuState extends State<AddMenu> with SingleTickerProviderStateMixin {
  double _opacity = 0;
  double _scale = 1;
  bool _isReverse = false;

  AnimationController _animationController;
  Animation<double> _opacityAnimator;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 150), value: 0);
    var curveAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    _opacityAnimator =
        Tween<double>(begin: 0.0, end: 1).animate(curveAnimation);
    _opacityAnimator.addListener(() {
      setState(() {
        _opacity = _opacityAnimator.value;
        if (_isReverse) {
          _scale = _opacity * 0.5 + 0.5;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: _opacity == 0,
      child: ColoredBox(
        color: Colors.transparent,
        child: Opacity(
            opacity: _opacity,
            child: Stack(
              children: <Widget>[
                GestureDetector(
                  onPanDown: (_) {
                    widget.dismissCall();
                  },
                ),
                Positioned(
                  right: 10,
                  top: 90,
                  child: Opacity(
                    opacity: _opacity,
                    child: Transform.scale(
                        scale: _scale,
                        alignment: Alignment(0.8, -1),
                        child: _buildMenuList()),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  @override
  void didUpdateWidget(AddMenu oldWidget) {
    if ((widget.show ? 1 : 0) != _opacity) {
      if (widget.show) {
        _isReverse = false;
        _scale = 1;
        _animationController.forward();
      } else {
        _isReverse = true;
        _animationController.reverse();
      }
      super.didUpdateWidget(oldWidget);
    }
  }

  Widget _buildMenuList() {
    return Stack(
      children: <Widget>[
        Positioned(
          right: 6,
          top: 0,
          child: Image.asset(
              Constant.assetsImagesChat.named("menu_up_arrow.png"),
              height: 10),
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                  width: 160,
                  height: (60 * _Item.items.length).toDouble(),
                  color: Color(0xFF4C4C4C),
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView.separated(
                      itemBuilder: (c, i) {
                        return SizedBox(
                          height: 60,
                          child: _buildItemWidget(
                              _Item.items[i].title, _Item.items[i].icon, () {
                            widget.dismissCall();
                          }),
                        );
                      },
                      separatorBuilder: (c, i) {
                        return new Divider(height: 1.0, color: Colors.white30);
                      },
                      itemCount: _Item.items.length,
                      physics: NeverScrollableScrollPhysics(),
                    ),
                  )),
            ))
      ],
    );
  }

  Widget _buildItemWidget(String title, String name, VoidCallback onPressed) {
    return FlatButton(
      onPressed: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(6),
            child: SvgPicture.asset(
              name,
              color: Colors.white,
              height: 30,
            ),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
              child: Text(title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.normal)))
        ],
      ),
    );
  }
}

class _Item {
  final String title;
  final String icon;
  const _Item({this.title, this.icon});

  static final List<_Item> items = [
    _Item(
        title: "发起群聊",
        icon: Constant.assetsImagesChat.named("icons_filled_add-friends.svg")),
    _Item(
        title: "添加朋友",
        icon: Constant.assetsImagesChat.named("icons_filled_chats.svg")),
    _Item(
        title: "扫一扫",
        icon: Constant.assetsImagesChat.named("icons_filled_scan.svg")),
    _Item(
        title: "收付款",
        icon: Constant.assetsImagesChat.named("icons_filled_pay.svg")),
  ];
}
