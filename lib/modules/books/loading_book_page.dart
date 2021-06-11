import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:paybook_app/modules/home/home_content_page.dart';

class LoadingBookPage implements HomeContentPage {
  @override
  Widget body() {
    return Center(child: CircularProgressIndicator());
  }

  @override
  void fabAction() {}

  @override
  bool isFABUsed() {
    return false;
  }
}
