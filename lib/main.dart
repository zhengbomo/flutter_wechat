import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/shares.dart';
import 'package:flutterwechat/data/constants/style.dart';
import 'package:flutterwechat/data/providers/main_badge_model.dart';
import 'package:flutterwechat/ui/components/navigator_service.dart';
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
