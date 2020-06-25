import 'package:flutter/material.dart';

class AutoKeepAliveState<T extends StatefulWidget> extends State<T> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
}

