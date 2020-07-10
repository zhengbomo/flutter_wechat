import 'package:flutter/material.dart';

class IndexBar extends StatefulWidget {
  final int index;
  final List<String> keys;
  final ValueChanged<int> indexChanged;
  IndexBar({this.index, this.keys, this.indexChanged});
  @override
  _IndexBarState createState() => _IndexBarState();
}

class _IndexBarState extends State<IndexBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ...List.generate(widget.keys.length, (i) {
            return FlatButton(
              child: Text(
                "${widget.keys[i]}",
                style: TextStyle(
                  color: i == widget.index ? Colors.red : Colors.black,
                ),
              ),
              onPressed: () {
                widget.indexChanged(i);
              },
            );
          })
        ],
      ),
    );
  }
}
