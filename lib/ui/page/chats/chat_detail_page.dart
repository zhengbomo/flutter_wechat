import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutterwechat/data/constants/constants.dart';
import 'package:flutterwechat/data/providers/chat_message_model.dart';
import 'package:flutterwechat/ui/page/chats/chat_editor.dart';
import 'package:provider/provider.dart';


class ChatDetailPage extends StatefulWidget {
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    // _scrollController.addListener(() {
    //   FocusScope.of(context).requestFocus(FocusNode());
    // });

    Future.delayed(Duration(seconds: 2)).then((value) {
      var scrollPosition = this._scrollController.position;

      if (scrollPosition.viewportDimension < scrollPosition.maxScrollExtent) {
        _scrollController.animateTo(
          scrollPosition.maxScrollExtent,
          duration: new Duration(milliseconds: 250),
          curve: Curves.easeInOut,
        );
      }
    });
    


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("傻姑1005"),
      ),
      body: Stack(
        children: <Widget>[
          _buildMessageList(context),
          // Positioned(
          //   bottom: 0,
          //   child: 
          ChatEditor(keyboardFocused: () {
              var scrollPosition = this._scrollController.position;

              if (scrollPosition.viewportDimension < scrollPosition.maxScrollExtent) {
                _scrollController.animateTo(
                  scrollPosition.maxScrollExtent,
                  duration: new Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                );
              }
            }),
          // )
        ],
      ),
    );
  }

  Widget _buildMessageList(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      child: Scrollbar(
        child: Listener(
          onPointerDown: (_) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: ChangeNotifierProvider(
            create: (_) => ChatMessageModel(),
            child: Builder(
              builder: (c) {
                return ListView.builder(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 12),
                  dragStartBehavior: DragStartBehavior.start,
                  controller: _scrollController,
                  itemBuilder: (c, i) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                              child: Image.asset(Constant.assetsImagesMock.named("glory_of_kings.png"), width: 50, height: 50),
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 200),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(3)
                                ),
                                child: Text("fdsfdsafsdafdsfdsafsdafdsfdsafsdafdsfdsafsdafdsfdsafsdafdsfdsafsdafdsfdsafsdafdsfdsafsdafdsfdsafsdafdsfdsafsdafdsfdsafsdafdsfdsafsdafdsfdsafsdafdsfdsafsdafdsfdsafsdafdsfdsafsda"),
                              ),
                            ),
                            Expanded(child: ConstrainedBox(constraints: BoxConstraints(minWidth: 100))),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: c.watch<ChatMessageModel>().messages.length
                );
              },
            ) 
          ) ,
        )
      )
    );
  }
}