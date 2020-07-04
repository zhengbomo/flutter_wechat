import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/shares.dart';
import 'package:flutterwechat/ui/components/search_list_page.dart';
import 'package:flutterwechat/ui/page/main/search_panel.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int _suspensionHeight = 40;
  int _itemHeight = 60;
  String _suspensionTag = "";

  List<ContactInfo> _contacts = List();

  @override
  void initState() {
    List.generate(1, (index) {
      _contacts.add(ContactInfo(name: "八戒", index: "B"));
      _contacts.add(ContactInfo(name: "沙和尚", index: "S"));
      _contacts.add(ContactInfo(name: "唐僧", index: "T"));
      _contacts.add(ContactInfo(name: "孙悟空", index: "S"));
      _contacts.add(ContactInfo(name: "悟净", index: "W"));
      _contacts.add(ContactInfo(name: "悟能", index: "W"));
      _contacts.add(ContactInfo(name: "悟空", index: "W"));
      return null;
    });
    _contacts.sort((a, b) => a.index.compareTo(b.index));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SearchListPage(
      appbar: AppBar(
        title: Text("通讯录"),
      ),
      builder: (context, searchBar) {
        print("dddd");
        return Container(
          color: Colors.white,
          child: AzListView(
            physics: AlwaysScrollableScrollPhysics(),
            header: AzListViewHeader(
              builder: (context) {
                return searchBar;
              },
              height: 50,
            ),
            data: _contacts,
            // topData: _hotCityList,
            itemBuilder: (context, model) => _buildListItem(model),
            suspensionWidget: _buildSusWidget(_suspensionTag),

            isUseRealIndex: true,
            indexBarBuilder: (context, tags, onTouch) {
              return IndexBar(
                touchDownColor: null,
                data: tags,
                width: 36,
                onTouch: onTouch,
              );
            },
            itemHeight: _itemHeight,
            suspensionHeight: _suspensionHeight,
            onSusTagChanged: _onSusTagChanged,
            //showCenterTip: false,
          ),
        );
      },
      searchPanel: SearchPanel(),
    );
  }

  void _onSusTagChanged(String tag) {
    setState(() {
      _suspensionTag = tag;
    });
  }

  Widget _buildSusWidget(String susTag) {
    return Container(
      height: _suspensionHeight.toDouble(),
      padding: const EdgeInsets.only(left: 15.0),
      color: Color(0xfff3f4f5),
      alignment: Alignment.centerLeft,
      child: Text(
        '$susTag',
        softWrap: false,
        style: TextStyle(
          fontSize: 14.0,
          color: Color(0xff999999),
        ),
      ),
    );
  }

  Widget _buildListItem(ContactInfo model) {
    String susTag = model.getSuspensionTag();
    return Column(
      children: <Widget>[
        Offstage(
          offstage: model.isShowSuspension != true,
          child: _buildSusWidget(susTag),
        ),
        Container(
          // style: ListTileStyle.drawer,
          // color: Colors.white,
          child: FlatButton(
            padding: EdgeInsets.zero,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 12),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: model.avatar,
                        ),
                      ),
                      Text(model.name)
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                ),
              ],
            ),
            onPressed: () {
              print("OnItemClick: $model");
            },
          ),
        ),
      ],
    );
  }
}

class ContactInfo extends ISuspensionBean {
  String name;
  String index;
  Color avatar;

  ContactInfo({
    this.name,
    this.index,
    Color avatar,
  }) : this.avatar = avatar ?? Shares.randomColor.randomColor();

  @override
  String getSuspensionTag() => this.index;
}
