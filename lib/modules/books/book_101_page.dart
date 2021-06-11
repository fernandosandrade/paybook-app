import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:paybook_app/data/models/cobranca/cobranca_111_model.dart';
import 'package:paybook_app/modules/home/home_content_page.dart';
import 'package:paybook_app/modules/home/home_page_header_widget.dart';
import 'package:paybook_app/modules/home/home_page_widget.dart';

import 'book_101_controller.dart';
import 'card_cobranca_111.dart';

class Book101Page extends StatelessWidget implements HomeContentPage {
  final Book101Controller controller;

  final String bookID;

  Book101Page(String parameter)
      : controller = Get.put(Book101Controller(), tag: parameter),
        this.bookID = parameter;

  @override
  Widget build(BuildContext context) {
    return GetX<Book101Controller>(
        tag: this.bookID,
        init: controller,
        builder: (controller) {
          return HomePageWidget(headerWidget: _header(), list: _list(), isFABUsed: isFABUsed(), fabAction: fabAction);
        });
  }

  HomePageHeaderWidget _header() {
    return HomePageHeaderWidget(bookID: bookID, nomeBook: 'nome book', totalCobrancas: 5, valorTotal: 100.00);
  }

  // Widget _list() {
  //   return controller.obx(
  //     (state) {
  //       return SliverToBoxAdapter(child: Center(child: Text('result')));
  //     },
  //     onLoading: SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),
  //     onError: (e) => SliverToBoxAdapter(child: Center(child: Text('erro'))),
  //   );
  // }

  Widget _list() {
    if (controller.chargesStream == null) {
      return SliverToBoxAdapter(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      List<Cobranca111Model?> list = controller.chargesStream.value;
      if (list.isNotEmpty) {
        return SliverList(
            delegate: SliverChildBuilderDelegate((_, index) {
          return CardCobranca111(
            cobrancaSimplesModel: list[index]!,
          );
        }, childCount: controller.totalCobrancas));
      } else {
        return SliverToBoxAdapter(
          child: Center(
            child: Text('nenhuma cobrança neste book'),
          ),
        );
      }
    }
  }

  @override
  void fabAction() {
    //Get.rawSnackbar(title: 'titulo', messageText: Text('mensagem'));
  }

  @override
  bool isFABUsed() {
    return true;
  }
}
