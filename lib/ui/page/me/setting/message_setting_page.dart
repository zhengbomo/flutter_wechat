import 'package:flutter/material.dart';
import 'package:flutterwechat/ui/view/bm_appbar.dart';

class MessageSettingPage extends StatefulWidget {
  @override
  _MessageSettingPageState createState() => _MessageSettingPageState();
}

class _MessageSettingPageState extends State<MessageSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BMAppBar(),
    );
  }
}
