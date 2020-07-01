import 'package:flutter/material.dart';
import 'package:flutterwechat/ui/page/main/main_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 500)).then((_) {
      _next();
    });
    super.initState();
  }

  _next() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return MainPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: FlatButton(
          onPressed: _next,
          child: Text("next"),
        ),
      ),
    );
  }
}
