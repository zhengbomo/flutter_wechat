import 'package:flutter/material.dart';

class SearchPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 40, bottom: 20),
            child: Text("搜索指定内容"),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _createButton(
                  "朋友圈",
                  () {},
                ),
                SizedBox(
                  height: 20,
                  child: VerticalDivider(
                    width: 30,
                    color: Colors.black12,
                    thickness: 1,
                  ),
                ),
                _createButton(
                  "文章",
                  () {},
                ),
                SizedBox(
                  height: 20,
                  child: VerticalDivider(
                    width: 30,
                    color: Colors.black12,
                    thickness: 1,
                  ),
                ),
                _createButton(
                  "公众号",
                  () {},
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.zero,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _createButton(
                  "小程序",
                  () {},
                ),
                SizedBox(
                  height: 20,
                  child: VerticalDivider(
                    width: 30,
                    color: Colors.black12,
                    thickness: 1,
                  ),
                ),
                _createButton(
                  "音乐",
                  () {},
                ),
                SizedBox(
                  height: 20,
                  child: VerticalDivider(
                    width: 30,
                    color: Colors.black12,
                    thickness: 1,
                  ),
                ),
                _createButton(
                  "表情",
                  () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _createButton(String title, VoidCallback onPressed) {
    return SizedBox(
        width: 80,
        child: FlatButton(
          padding: EdgeInsets.zero,
          onPressed: onPressed,
          child: Text(
            title,
            style: TextStyle(fontSize: 18, color: Colors.blueAccent),
          ),
        ));
  }
}
