import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'home_content_page.dart';

class HomeContentDelegate {
  final HomeContentPage homeContentPage;

  HomeContentDelegate._(this.homeContentPage);

  HomeContentDelegate.from(this.homeContentPage);

  Widget content() => homeContentPage.content();

  Widget loading() {
    return Center(child: CircularProgressIndicator());
  }

  void fabDelegate() {}

  bool fabIsUsed() {
    return false;
  }

  Widget getBookList() {
    return Center(child: CircularProgressIndicator());
  }

  void novaCobranca() {
    Get.rawSnackbar(message: 'carregando book');
  }
}
