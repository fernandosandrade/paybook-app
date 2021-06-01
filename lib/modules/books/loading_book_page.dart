import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:paybook_app/modules/home/home_content_page.dart';

class LoadingBookPage implements HomeContentPage {
  @override
  Widget content() {
    return Center(child: CircularProgressIndicator());
  }

  @override
  void fabDelegate() {}

  @override
  bool fabIsUsed() {
    return false;
  }
}
