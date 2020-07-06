import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/style.dart';
import 'package:flutterwechat/ui/components/normal_cell_info.dart';
import 'package:flutterwechat/ui/components/section_list_view.dart';
import 'package:flutterwechat/ui/page/base/auto_keep_alive_state.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends AutoKeepAliveState<DiscoverPage> {
  var _items = List<List<NormalCellInfo>>();
  bool _isOn = false;
  @override
  void initState() {
    _items.add([
      NormalCellInfo(
        title: "朋友圈",
        icon: Icon(Icons.android),
        leading: Container(
          color: Colors.red,
          margin: EdgeInsets.only(right: 12),
          width: 40,
          height: 40,
          child: CircleAvatar(
            radius: 3,
            backgroundColor: Colors.blue,
          ),
        ),
        onPressed: () {},
      ),
      NormalCellInfo(title: "扫一扫", icon: Icon(Icons.iso), onPressed: () {})
    ]);

    _items.add([
      NormalCellInfo(title: "看一看", icon: Icon(Icons.looks)),
      NormalCellInfo(title: "瞧一瞧"),
      NormalCellInfo(title: "看一看", icon: Icon(Icons.looks), showArrow: false),
      NormalCellInfo(
        title: "瞧一瞧",
        icon: Icon(Icons.receipt),
        showArrow: false,
        leading: StatefulBuilder(builder: (context, setState) {
          return CupertinoSwitch(
            value: _isOn,
            onChanged: (v) {
              setState(() {
                _isOn = !_isOn;
              });
            },
          );
        }),
      ),
    ]);

    _items.add([
      NormalCellInfo(title: "看一看", icon: Icon(Icons.looks)),
      NormalCellInfo(title: "瞧一瞧", icon: Icon(Icons.receipt)),
      NormalCellInfo(title: "看一看", icon: Icon(Icons.looks)),
      NormalCellInfo(title: "瞧一瞧", icon: Icon(Icons.receipt)),
      NormalCellInfo(title: "看一看", icon: Icon(Icons.looks)),
      NormalCellInfo(title: "瞧一瞧", icon: Icon(Icons.receipt)),
      NormalCellInfo(title: "看一看", icon: Icon(Icons.looks)),
      NormalCellInfo(title: "瞧一瞧", icon: Icon(Icons.receipt)),
      NormalCellInfo(title: "看一看", icon: Icon(Icons.looks)),
      NormalCellInfo(title: "瞧一瞧", icon: Icon(Icons.receipt)),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("发现"),
      ),
      body: Container(
        child: SectionListView(
          header: Container(
            color: Colors.red,
            height: 100,
          ),
          numberOfSection: () => _items.length,
          numberOfRowsInSection: (section) => _items[section].length,
          rowWidget: (context, section, row) {
            NormalCellInfo cellInfo = _items[section][row];
            return SizedBox(
              height: 60,
              child: FlatButton(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          if (cellInfo.icon != null) cellInfo.icon,
                          Expanded(
                            child: Padding(
                              child: Text(cellInfo.title),
                              padding: EdgeInsets.only(
                                  left: cellInfo.icon != null ? 12 : 0,
                                  right: 12),
                            ),
                          ),
                          if (cellInfo.leading != null) cellInfo.leading,
                          if (cellInfo.showArrow)
                            Icon(Icons.keyboard_arrow_right),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      indent: 36,
                    )
                  ],
                ),
                onPressed: () {},
              ),
            );
          },
          sectionWidget: (context, section) {
            if (section == 0) {
              return null;
            } else {
              return Container(
                height: 10,
                color: Style.primaryColor,
              );
            }
          },
        ),
      ),
    );
  }
}
