import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/shares.dart';
import 'package:flutterwechat/data/constants/style.dart';
import 'package:flutterwechat/data/providers/main_badge_model.dart';
import 'package:flutterwechat/ui/components/navigator_service.dart';
import 'package:flutterwechat/ui/page/base/auto_keep_alive_state.dart';
import 'package:flutterwechat/ui/page/main/main_page.dart';
import 'package:flutterwechat/ui/page/test_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'wechat',
      navigatorKey: NavigatorService.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
            button: TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
        splashFactory: Shares.noInkFeatureFactory,
        buttonTheme: ButtonThemeData(
          minWidth: 0,
          height: 0,
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          textTheme: TextTheme(
            headline6: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ),
        primaryColor: Style.primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Style.pBackgroundColor,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => MainBadgeModel(selectedIndex: 2),
          )
        ],
        child: MainPage(),
      ),
    );
  }
}

class TestDD extends StatefulWidget {
  @override
  _TestDDState createState() => _TestDDState();
}

class _TestDDState extends State<TestDD> {
  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: PageView(
        children: <Widget>[
          TestEE(),
          TestEE(),
          TestEE(),
          TestEE(),
          TestEE(),
        ],
      ),
    );
  }
}

class TestEE extends StatefulWidget {
  @override
  _TestEEState createState() => _TestEEState();
}

class _TestEEState extends AutoKeepAliveState<TestEE> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("build");
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => TestDD()));
            },
          )
        ],
      ),
      body: Container(
        color: Shares.randomColor.randomColor(),
        child: Center(
          child: Builder(
            builder: (context) {
              return MediaQuery.removePadding(
                context: context,
                // removeTop: true,
                // removeBottom: false,
                child: TextField(),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    print("did change depency");
    super.didChangeDependencies();
  }
}
