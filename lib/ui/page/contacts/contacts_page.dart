import 'package:flutter/material.dart';
import 'package:flutterwechat/ui/page/base/auto_keep_alive_state.dart';


class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends AutoKeepAliveState<ContactsPage> {

  @override
  void initState() {
    print("contact page init");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("通讯录"),
      ),
      body: Container(

      ),
    );
  }
}
