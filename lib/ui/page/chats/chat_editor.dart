import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_utils/keyboard_listener.dart';
import 'package:keyboard_utils/keyboard_utils.dart';


class ChatEditor extends StatefulWidget {
  final VoidCallback keyboardFocused;

  ChatEditor({this.keyboardFocused});

  @override
  _ChatEditorState createState() => _ChatEditorState();
}

class _ChatEditorState extends State<ChatEditor> with SingleTickerProviderStateMixin{
  TextEditingController _editingController;

  FocusNode _focusNode = FocusNode();

  KeyboardUtils  _keyboardUtils = KeyboardUtils();
  
  int _subscribingId;
  double _bottomHeight = 0;

  @override
  void initState() {
    _focusNode.addListener(() {
      widget.keyboardFocused();
    });

    _editingController = TextEditingController(text: "Fdsfdsafdsafdsafdsafdsaf dafdsafdsafdsa fdasf dsaf dsa");
    // _editingController.addListener(() {
    //   print("aaaaa");
    // });
    _subscribingId = _keyboardUtils.add(listener: KeyboardListener(willShowKeyboard: (height) {
      print(height);
      setState(() {
        _bottomHeight = height;  
      });
      
    }, willHideKeyboard: () {
      _bottomHeight = 0;
    }));
    
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _keyboardUtils.unsubscribeListener(subscribingId: _subscribingId);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Column(
        children: <Widget>[
          Container(
            height: 60,
            color: Colors.black12,
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {

                  },
                  icon: Icon(Icons.alarm),
                ),
                Expanded(
                  child: CupertinoTextField(
                    focusNode: _focusNode,
                    placeholder: "dd",
                    controller: _editingController,                
                  )
                ),
                IconButton(
                  onPressed: () {

                  },
                  icon: Icon(Icons.people),
                ),
                IconButton(
                  onPressed: () {

                  },
                  icon: Icon(Icons.people),
                ),
              ],
            ),
          ),
          AnimatedSize(
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: 250),            
            vsync: this,
            child: SizedBox(height: _bottomHeight),
          )
          ,
        ],
      )
    );
  }
}