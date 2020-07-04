import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/shares.dart';
import 'package:flutterwechat/data/constants/style.dart';
import 'package:flutterwechat/data/providers/list_search_bar_model.dart';
import 'package:flutterwechat/data/providers/main_badge_model.dart';
import 'package:flutterwechat/ui/page/moment_page.dart';
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        splashFactory: Shares.noInkFeatureFactory,
        buttonTheme: ButtonThemeData(minWidth: 0, height: 0),
        appBarTheme: AppBarTheme(elevation: 1),
        primaryColor: Style.primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Style.pBackgroundColor,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => MainBadgeModel(selectedIndex: 1))
        ],
        child: MomentPage(),
      ),
    );
  }
}
