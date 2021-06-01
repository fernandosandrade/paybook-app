import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:paybook_app/modules/home/home_content_page.dart';

class Book101Page implements HomeContentPage {
  @override
  Widget content() {
    return Center(child: Text("book 101"));
  }

  @override
  void fabDelegate() {
    // TODO: implement fabDelegate
  }

  @override
  bool fabIsUsed() {
    // TODO: implement fabIsUsed
    throw UnimplementedError();
  }
}
