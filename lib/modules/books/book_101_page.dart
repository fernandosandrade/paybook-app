import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:paybook_app/data/models/book/book_101_model.dart';
import 'package:paybook_app/data/models/charge/charge_111_model.dart';
import 'package:paybook_app/modules/home/home_content_page.dart';
import 'package:paybook_app/modules/home/home_controller.dart';
import 'package:paybook_app/modules/home/home_page_header_widget.dart';
import 'package:paybook_app/modules/home/home_page_widget.dart';
import 'package:paybook_app/routes/app_pages.dart';
import 'package:paybook_app/services/enum_book_type.dart';
import 'package:paybook_app/services/enum_charge_type.dart';

import 'book_101_controller.dart';
import 'charge111/card_cobranca_111.dart';

class Book101Page extends StatelessWidget implements HomeContentPage {
  final Book101Controller controller;

  Book101Page(String bookId) : controller = Get.find<Book101Controller>(tag: bookId);

  @override
  Widget build(BuildContext context) {
    return GetX<Book101Controller>(
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
          tipoBook: EnumBookType.B_101,
          nomeBook: this.controller.book101modelStream.value!.name,
          totalCobrancas: this.controller.totalCobrancas,
          valorTotal: this.controller.totalValue,
          editBook: _editarBook,
          deleteBook: _deletarBook);
    } else {
      return HomePageHeaderWidget(
          bookID: '-',
          tipoBook: EnumBookType.B_101,
          nomeBook: 'loading...',
          totalCobrancas: 0,
          valorTotal: 0,
          editBook: _editarBook,
          deleteBook: _deletarBook);
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
    Get.toNamed(AppRoutes.Charges.chargeFormURLBuild(
        tipoBook: EnumBookType.B_101,
        tipoCobranca: EnumChargeType.C_111,
        bookId: controller.bookId));
  }

  @override
  bool isFABUsed() {
    return true;
  }

  void _editarBook() {
    Get.toNamed(
            AppRoutes.Books.bookFormURLBuild(
                tipoBook: EnumBookType.B_101, bookId: controller.bookId),
            arguments: controller.book101modelStream.value)!
        .then((_) => controller.loadBook());
  }

  void _deletarBook() {
    print('delete book ${controller.bookId}');
  }
}
