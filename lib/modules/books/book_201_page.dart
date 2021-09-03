import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:paybook_app/modules/home/home_content_page.dart';
import 'package:paybook_app/modules/home/home_controller.dart';
import 'package:paybook_app/modules/home/home_page_header_widget.dart';
import 'package:paybook_app/modules/home/home_page_widget.dart';
import 'package:paybook_app/routes/app_pages.dart';
import 'package:paybook_app/services/enum_book_type.dart';

import 'book_201_controller.dart';

class Book201Page extends StatelessWidget implements HomeContentPage {
  final controller;

  final bookID;

  Book201Page(String? parameter)
      : controller = Get.put(Book201Controller(), tag: parameter),
        this.bookID = parameter;

  @override
  Widget build(BuildContext context) {
    return HomePageWidget(
        headerWidget: _header(), list: _list(), isFABUsed: isFABUsed(), fabAction: fabAction);
  }

  HomePageHeaderWidget _header() {
    return HomePageHeaderWidget(
        bookID: bookID,
        tipoBook: EnumBookType.B_201,
        nomeBook: 'nome book',
        totalCobrancas: 5,
        valorTotal: 10000,
        editBook: _editarBook,
        deleteBook: _deletarBook);
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

  void _editarBook() {
    var future = Get.toNamed(
        AppRoutes.Books.bookFormURLBuild(tipoBook: EnumBookType.B_201, bookId: controller.bookId),
        arguments: controller.book101modelStream.value);
    if (future != null) Get.find<HomeController>().reloadBook();
  }

  void _deletarBook() {
    print('delete book ${controller.bookId}');
  }
}
