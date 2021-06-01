import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:paybook_app/modules/home/home_page.dart';

class Book201Page extends HomePage {
  @override
  Widget homeContent() {
    return Center(child: Text("book 201"));
  }

  @override
  Function fabAction() {
    return () => Get.rawSnackbar(title: 'fab', messageText: Text('fab action'));
  }

  @override
  bool isFABUsed() {
    return false;
  }
}
