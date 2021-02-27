import 'package:flutter/material.dart';

class GlobalScaffold {
  static final GlobalScaffold _instance = GlobalScaffold._internal();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  factory GlobalScaffold() {
    return _instance;
  }

  GlobalScaffold._internal();

  void showSnackBar(SnackBar snackBar) {
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
}
