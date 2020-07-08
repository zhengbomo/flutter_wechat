import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterwechat/data/constants/constants.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  // final ges = TapGestureRecognizer();
  // ges.onTap = () {};
  List<String> _likes = ["小白"];

  Widget _likeText() {
    var spans = List<InlineSpan>();
    spans.add(WidgetSpan(
      child: SvgPicture.asset(
          Constant.assetsImagesDiscover.named("icons_outlined_like.svg"),
          width: 18),
    ));
    for (var i = 0; i < _likes.length; i++) {
      spans.add(
        TextSpan(
          text: _likes[i],
          // recognizer: TapGestureRecognizer()
          //   ..onTap = () {
          //     print("tap");
          //   },
        ),
      );
      if (i < _likes.length - 1) {
        spans.add(TextSpan(text: ", "));
      }
    }
    return Text.rich(TextSpan(
      children: spans,
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: ListView.builder(
          itemBuilder: (context, i) {
            return Text.rich(TextSpan(
              children: <InlineSpan>[
                TextSpan(
                    text: 'Flutter is',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print("first");
                      }),
                WidgetSpan(
                    child: SizedBox(
                  width: 120,
                  height: 50,
                  child: Card(child: Center(child: Text('Hello World!'))),
                )),
                ..._likes.map((e) => TextSpan(
                    text: '$e',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print("second");
                      }))
              ],
            ));
          },
          itemCount: 100,
        ),
      ),
    );
  }
}
