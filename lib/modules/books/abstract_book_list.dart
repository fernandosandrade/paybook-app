import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/home_controller.dart';

class AbstractBookList {
  Widget getBookList() {
    return Center(child: CircularProgressIndicator());
  }

  void novaCobranca() {
    Get.rawSnackbar(message: 'carregando book');
  }
}
