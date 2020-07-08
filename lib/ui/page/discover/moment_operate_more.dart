import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterwechat/data/constants/constants.dart';

class MomentOperateMore extends StatefulWidget {
  final double top;
  final bool show;
  final VoidCallback dismiss;
  final VoidCallback onLike;
  final VoidCallback onComment;

  MomentOperateMore({
    @required this.top,
    @required this.show,
    @required this.dismiss,
    @required this.onLike,
    @required this.onComment,
  });

  @override
  _MomentOperateMoreState createState() => _MomentOperateMoreState();
}

class _MomentOperateMoreState extends State<MomentOperateMore> {
  Widget _content;
  bool _hasShow = false;

  @override
  void initState() {
    _hasShow = widget.show;
    _content = _createContent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: widget.show ? false : !_hasShow,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onPanDown: (_) {
              widget.dismiss();
            },
          ),
          Positioned(
            top: widget.top,
            right: 60,
            height: 40,
            width: 200,
            child: Stack(
              overflow: Overflow.clip,
              children: <Widget>[
                AnimatedPositioned(
                  curve: Curves.easeInOut,
                  onEnd: () {
                    if (!widget.show) {
                      setState(() {
                        _hasShow = false;
                      });
                    } else {
                      _hasShow = true;
                    }
                  },
                  duration: Duration(milliseconds: 150),
                  top: 0,
                  bottom: 0,
                  width: 200,
                  left: widget.show ? 0 : 200,
                  child: _content,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _createContent() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Color(0xff424242),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: _createMoreButton(
              Constant.assetsImagesDiscover.named("icons_outlined_like.svg"),
              "赞",
              widget.onLike,
            ),
          ),
          SizedBox(
            child: VerticalDivider(
              width: 1,
              color: Colors.white12,
            ),
          ),
          Expanded(
            child: _createMoreButton(
              Constant.assetsImagesDiscover.named("icons_outlined_comment.svg"),
              "评论",
              widget.onComment,
            ),
          )
        ],
      ),
    );
  }

  Widget _createMoreButton(String asset, String title, VoidCallback onPressed) {
    return SizedBox(
      width: 100,
      child: FlatButton(
        textColor: Colors.white,
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              asset,
              color: Colors.white,
              width: 24,
            ),
            Padding(
              padding: EdgeInsets.only(left: 6),
              child: Text(
                title,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
