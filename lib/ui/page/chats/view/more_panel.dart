import 'package:flutter/material.dart';

class MorePanel extends StatefulWidget {
  @override
  _MorePanelState createState() => _MorePanelState();
}

class _MorePanelState extends State<MorePanel> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Divider(
        height: 0.5,
        color: Colors.black12,
      ),
      Expanded(
          child: Padding(
              padding: EdgeInsets.fromLTRB(12, 24, 12, 24),
              child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, i) {
                    return Container(
                      // margin: EdgeInsets.all(8),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                              width: 70,
                              height: 70,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                onPressed: () {
                                  print("图片");
                                },
                                color: Colors.white60,
                                child: Icon(Icons.image),
                              )),
                          Text("图片")
                        ],
                      ),
                    );
                  },
                  itemCount: 7,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, childAspectRatio: 0.92))))
    ]);
  }
}
