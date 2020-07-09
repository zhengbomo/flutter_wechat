import 'package:flutter/material.dart';
import 'package:flutterwechat/ui/components/page_indicator/page_indicator.dart';
import 'package:tuple/tuple.dart';

class MorePanel extends StatelessWidget {
  final PageController _pageController = PageController();

  List<Tuple3<String, String, VoidCallback>> _firstPageData = [
    Tuple3("照片", "", () {}),
    Tuple3("拍摄", "", () {}),
    Tuple3("视频通话", "", () {}),
    Tuple3("位置", "", () {}),
    Tuple3("红包", "", () {}),
    Tuple3("转账", "", () {}),
    Tuple3("语音输入", "", () {}),
    Tuple3("收藏", "", () {}),
  ];

  List<Tuple3<String, String, VoidCallback>> _secondPageData = [
    Tuple3("个人名片", "", () {}),
    Tuple3("文件", "", () {}),
    Tuple3("卡券", "", () {}),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Divider(
        height: 0.5,
        color: Colors.black12,
      ),
      Expanded(
        child: Stack(
          children: <Widget>[
            PageView(
              controller: _pageController,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(12, 24, 12, 24),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i) {
                      return _createItem(
                          _firstPageData[i].item1, _firstPageData[i].item2);
                    },
                    itemCount: _firstPageData.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 0.82,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(12, 24, 12, 24),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i) {
                      return _createItem(
                          _secondPageData[i].item1, _secondPageData[i].item2);
                    },
                    itemCount: _secondPageData.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 0.82,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                child: PageIndicator(
                  layout: PageIndicatorLayout.NONE,
                  color: Color(0xffcbcdd4),
                  activeColor: Color(0xff696a6d),
                  count: 2,
                  size: 6.0,
                  space: 8.0,
                  controller: _pageController,
                ),
              ),
            )
          ],
        ),
      )
    ]);
  }

  Widget _createItem(String title, String icon) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: SizedBox(
            width: 70,
            height: 70,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              onPressed: () {
                print(title);
              },
              color: Colors.white60,
              child: Icon(Icons.image),
            ),
          ),
        ),
        Text(title)
      ],
    );
  }
}
