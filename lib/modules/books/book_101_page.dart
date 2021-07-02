import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:paybook_app/data/models/charge/charge_111_model.dart';
import 'package:paybook_app/data/models/cobranca/cobranca_111_model.dart';
import 'package:paybook_app/modules/home/home_content_page.dart';
import 'package:paybook_app/modules/home/home_page_header_widget.dart';
import 'package:paybook_app/modules/home/home_page_widget.dart';
import 'package:paybook_app/routes/app_pages.dart';
import 'package:paybook_app/services/enum_tipo_book.dart';
import 'package:paybook_app/services/enum_tipo_cobranca.dart';

import 'book_101_controller.dart';
import 'charge111/card_cobranca_111.dart';

class Book101Page extends StatelessWidget implements HomeContentPage {
  final Book101Controller controller;

  Book101Page(String bookId) : controller = Get.find<Book101Controller>(tag: bookId);

  @override
  Widget build(BuildContext context) {
    return GetX<Book101Controller>(
        // tag: this.bookID,
        init: controller,
        builder: (controller) {
          return ModalProgressHUD(
              inAsyncCall: controller.isLoading.isTrue,
              child: HomePageWidget(
                  headerWidget: _header(),
                  list: _list(),
                  isFABUsed: isFABUsed(),
                  fabAction: fabAction));
        });
  }

  HomePageHeaderWidget _header() {
    if (this.controller.book101modelStream.value != null) {
      return HomePageHeaderWidget(
          bookID: this.controller.bookId,
          nomeBook: this.controller.book101modelStream.value!.nomeBook,
          totalCobrancas: this.controller.totalCobrancas,
          valorTotal: this.controller.totalValue);
    } else {
      return HomePageHeaderWidget(
          bookID: '-', nomeBook: 'loading...', totalCobrancas: 0, valorTotal: 0);
    }
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
    if (controller.chargesListStream == null) {
      return SliverToBoxAdapter(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      List<Charge111Model?> list = controller.chargesListStream.value;
      if (list.isNotEmpty) {
        return SliverList(
            delegate: SliverChildBuilderDelegate((_, index) {
          return CardCobranca111(
            bookId: controller.bookId,
            charge111Model: list[index]!,
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
    Get.toNamed(AppRoutes.Charges.chargeFormURLBuild(
        tipoBook: EnumTipoBook.B_101,
        tipoCobranca: EnumTipoCobranca.C_111,
        bookId: controller.bookId));
    // '?${AppRoutes.Books.parameterBookId}=$bookID');
  }

  @override
  bool isFABUsed() {
    return true;
  }
}
