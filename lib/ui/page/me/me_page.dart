import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutterwechat/ui/page/base/auto_keep_alive_state.dart';
import 'package:provider/provider.dart';


class MePage extends StatefulWidget {
  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends AutoKeepAliveState<MePage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("我"),
      ),
      body: ChangeNotifierProvider(
        create: (_) {
          return TestModel();
        },
        child: Column(
          children: <Widget>[
            Builder(builder: (context) {
              return FlatButton(
                child: Text("change text"),
                onPressed: () {
                  context.read<TestModel>().changeText("${Random().nextInt(10)}");
                }
              );
            }),
            
            Builder(builder: (context) {
              return FlatButton(
                  child: Text("change num"),
                  onPressed: () {
                    context.read<TestModel>().changeNum(Random().nextInt(10));
                  }
              );
            }),
            Selector(builder: (context, int value, dd) {
              print("build num");
              return Text("num $value");
            }, selector: (context, TestModel model) {
              return model.num;
            }),
            Selector(builder: (context, String value, dd) {
              print("build text");
              return Text("text $value");
            }, selector: (context, TestModel model) {
              return model.text;
            }),
          ],
        ),
      )
    );
  }
}

class TestModel extends ChangeNotifier {
  String text = "tt";
  int num = 10;

  void changeText(String text) {
    if (this.text != text) {
      this.text = text;
      notifyListeners();
    }
  }

  void changeNum(int num) {
    if (this.num != num) {
      this.num = num;
      notifyListeners();
    }
  }


}
