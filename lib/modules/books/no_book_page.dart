import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:paybook_app/modules/home/home_content_page.dart';

class NoBookPage implements HomeContentPage {
  @override
  Widget content() {
    return Center(child: Text("nenhum book cadastrado"));
  }

  @override
  bool fabIsUsed() {
    return false;
  }

  @override
  void fabDelegate() {
    // TODO: implement fabDelegate
  }
}
