import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:paybook_app/modules/home/home_content_page.dart';
import 'package:paybook_app/modules/home/home_page_header_widget.dart';
import 'package:paybook_app/modules/home/home_page_widget.dart';

import 'book_201_controller.dart';

class Book201Page extends StatelessWidget implements HomeContentPage {
  final controller;

  final bookID;

  Book201Page(String? parameter)
      : controller = Get.put(Book201Controller(), tag: parameter),
        this.bookID = parameter;

  @override
  Widget build(BuildContext context) {
    return HomePageWidget(headerWidget: _header(), list: _list(), isFABUsed: isFABUsed(), fabAction: fabAction);
  }

  HomePageHeaderWidget _header() {
    return HomePageHeaderWidget(bookID: bookID, nomeBook: 'nome book', totalCobrancas: 5, valorTotal: 100.00);
  }

  Widget _list() {
    return SliverToBoxAdapter(
      child: Center(
        child: Text('book 201 sem cobracnas'),
      ),
    );
  }

  @override
  void fabAction() {
    Get.rawSnackbar(title: 'titulo', messageText: Text('mensagem'));
  }

  @override
  bool isFABUsed() {
    return true;
  }
}
