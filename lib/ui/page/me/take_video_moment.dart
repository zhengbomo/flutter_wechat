import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterwechat/data/constants/basic.dart';
import 'package:flutterwechat/data/constants/constants.dart';

class TakeVideoMoment extends StatefulWidget {
  final ValueChanged<Offset> panStart;
  final TwoValueCallback<Offset, Offset> panUpdate;
  final ValueChanged<Offset> panEnd;

  TakeVideoMoment({this.panStart, this.panUpdate, this.panEnd});

  @override
  _TakeVideoMomentState createState() => _TakeVideoMomentState();
}

class _TakeVideoMomentState extends State<TakeVideoMoment> {
  Offset _panStartPosition;
  Offset _panDeltaOffset;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (data) {
        _panStartPosition = data.localPosition;
        widget.panStart(_panStartPosition);
      },
      onPanUpdate: (data) {
        _panDeltaOffset = (data.localPosition - _panStartPosition);
        widget.panUpdate(data.localPosition, _panDeltaOffset);
      },
      onPanEnd: (data) {
        widget.panEnd(_panDeltaOffset);
      },
      child: Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Positioned(
                bottom: 100,
                left: 0,
                right: 0,
                child: Center(
                  child: FlatButton(
                    onPressed: () {
                      // _hidePai(context);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SvgPicture.asset(
                          Constant.assetsImagesMe
                              .named("icons_filled_camera.svg"),
                          width: 40,
                          color: Colors.blue,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            "拍一个视频动态",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
