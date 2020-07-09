import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterwechat/data/constants/constants.dart';
import 'package:flutterwechat/ui/components/avatar.dart';
import 'package:flutterwechat/ui/components/link_button.dart';
import 'package:flutterwechat/ui/page/discover/moment_info.dart';

class MomentCell extends StatelessWidget {
  final MomentInfo momentInfo;

  final ValueChanged<Offset> moreOperate;
  final ValueChanged<Offset> test;

  // final _likes = ["蜗牛骑士"];
  // final _comment = ["牛逼🐮", "哈哈哈", "今天晚上吃什么今天晚上吃什么今天晚上吃什么今天晚上吃什么今天晚上吃什么"];
  // final _comment = [];

  MomentCell(
      {@required this.momentInfo, @required this.moreOperate, this.test});

  Widget _likeText() {
    final color = Color(0xff364f80);
    final style = TextStyle(color: Colors.black);

    var spans = List<InlineSpan>();
    spans.add(WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: Container(
        width: 20,
        height: 20,
        margin: EdgeInsets.only(right: 5),
        child: SvgPicture.asset(
            Constant.assetsImagesDiscover.named("icons_outlined_like.svg"),
            width: 18,
            color: color),
      ),
    ));
    for (var i = 0; i < momentInfo.likes.length; i++) {
      spans.add(TextSpan(
          text: momentInfo.likes[i],
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              print(momentInfo.likes[i]);
            }));
      if (i < momentInfo.likes.length - 1) {
        spans.add(TextSpan(text: ", ", style: style));
      }
    }

    return Text.rich(TextSpan(
        style: TextStyle(color: color, fontSize: 16), children: spans));
  }

  Widget _commentList() {
    final color = Color(0xff364f80);
    final style = TextStyle(color: Colors.black);

    var spans = List<TextSpan>();
    for (var i = 0; i < momentInfo.comments.length; i++) {
      spans.add(TextSpan(
          text: "蜗牛骑士",
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              print(momentInfo.comments[i]);
            }));
      spans.add(TextSpan(text: ": ${momentInfo.comments[i]}", style: style));
      if (i < momentInfo.comments.length - 1) {
        spans.add(TextSpan(text: "\n"));
      }
    }

    return RichText(
      text: TextSpan(
        text: "",
        style: TextStyle(color: color, height: 1.5, fontSize: 16),
        children: spans,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Avatar(
                  borderRadius: 6,
                  color: Colors.red,
                  size: 50,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: LinkButton(
                            child: Text(this.momentInfo.username),
                            onPressed: () {},
                          ),
                        ),
                        Text(
                          this.momentInfo.content,
                          style: TextStyle(fontSize: 17),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 12, bottom: 6),
                          child: Wrap(
                            runSpacing: 8,
                            spacing: 8,
                            children: this
                                .momentInfo
                                .images
                                .map((e) => FlatButton(
                                      padding: EdgeInsets.zero,
                                      child: Container(
                                        width: 80,
                                        height: 80,
                                        color: e.withAlpha(100),
                                      ),
                                      onPressed: () {},
                                    ))
                                .toList(),
                          ),
                        ),
                        if (momentInfo.location != null)
                          LinkButton(
                            child: Text(
                              this.momentInfo.location,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            onPressed: () {},
                          ),
                        Row(
                          children: <Widget>[
                            Expanded(
                                child: Text(this.momentInfo.time.toString())),
                            SizedBox(
                              child: Builder(
                                builder: (context) {
                                  return IconButton(
                                    icon: Image.asset(
                                      Constant.assetsImagesDiscover
                                          .named("album_operate_more.png"),
                                      width: 30,
                                    ),
                                    onPressed: () {
                                      RenderBox box =
                                          context.findRenderObject();

                                      // RenderBox parent =
                                      //     parentContext.findRenderObject();
                                      // var pos = box.localToGlobal(Offset.zero,
                                      //     ancestor: parent);
                                      this.moreOperate(
                                          box.localToGlobal(Offset.zero));
                                      // this.test(pos);
                                    },
                                  );
                                },
                              ),
                              height: 40,
                            )
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(left: 0, right: 0),
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          color: Color(0xfff5f5f5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              if (momentInfo.likes.length > 0)
                                Container(
                                  child: _likeText(),
                                ),
                              if (momentInfo.likes.length > 0)
                                Divider(
                                  height: 1,
                                ),
                              if (momentInfo.comments.length > 0)
                                Container(
                                  child: _commentList(),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
        ],
      ),
    );
  }
}
