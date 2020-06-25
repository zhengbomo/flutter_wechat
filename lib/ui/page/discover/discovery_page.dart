import 'package:flutter/material.dart';
import 'package:flutterwechat/ui/page/base/auto_keep_alive_state.dart';


class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends AutoKeepAliveState<DiscoverPage> {

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("发现"),
      ),
      body: Container(

      ),
    );
  }
}
