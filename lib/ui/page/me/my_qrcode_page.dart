import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterwechat/data/constants/constants.dart';
import 'package:flutterwechat/ui/components/avatar.dart';
import 'package:flutterwechat/ui/view/bm_appbar.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyQrcodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BMAppBar(
        title: Text("我的二维码"),
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset(
                Constant.assetsImagesChat.named("icons_filled_more.svg")),
            onPressed: () {},
          )
        ],
      ),
      body: Center(
        heightFactor: 1.5,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          height: 420,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(24, 24, 12, 0),
                    child: Avatar(
                      borderRadius: 8,
                      color: Colors.blue,
                      size: 64,
                      userInteractionEnable: false,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 24, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                "八戒",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Image.asset(
                                  Constant.assetsImagesContacts
                                      .named("contact_male.png"),
                                  width: 20,
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              "广东广州",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Container(
                width: 250,
                height: 250,
                margin: EdgeInsets.only(top: 30, bottom: 20),
                child: QrImage(
                  data: 'This is a simple QR code xxxxxxxxx',
                  version: QrVersions.auto,
                  // size: 250,
                  gapless: false,
                ),
              ),
              Text(
                "扫一扫上面的二维码图案，加我微信",
                style: TextStyle(color: Colors.black54, fontSize: 12),
              )
            ],
          ),
        ),
      ),
    );
  }
}
