import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:paybook_app/data/models/charge/charge_111_model.dart';
import 'package:paybook_app/modules/home/home_content_page.dart';
import 'package:paybook_app/modules/home/home_page_header_widget.dart';
import 'package:paybook_app/modules/home/home_page_widget.dart';
import 'package:paybook_app/routes/app_pages.dart';
import 'package:paybook_app/services/enum_book_type.dart';
import 'package:paybook_app/services/enum_charge_type.dart';
import 'package:paybook_app/utils/formatters.dart';
import 'package:paybook_app/widgets/charge_status_chip_widget.dart';

import 'book_101_home_controller.dart';

class Book101HomePage extends StatelessWidget implements HomeContentPage {
  final Book101HomeController controller;

  Book101HomePage(String bookId) : controller = Get.find<Book101HomeController>(tag: bookId);

  @override
  Widget build(BuildContext context) {
    return GetX<Book101HomeController>(
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
    if (controller.chargesListStream.isEmpty) {
      return SliverToBoxAdapter(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      List<Charge111Model?> list = controller.chargesListStream;
      if (list.isNotEmpty) {
        return SliverList(
            delegate: SliverChildBuilderDelegate((_, index) {
          return _CardCharge111(
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

class _CardCharge111 extends StatelessWidget {
  final String bookId;
  final Charge111Model charge111Model;

  _CardCharge111({required this.bookId, required this.charge111Model});

  @override
  Widget build(BuildContext context) {
    var nomeDestinatario = charge111Model.receiver.nome;
    var valor = 'R\$ ${Formatters.currencyPtBr(charge111Model.amount)}';
    // var vencimento = Formatters.simpleDate(charge111Model.expirationDate);
    var vencimento = DateFormat.MMMd('pt_BR').format(charge111Model.expirationDate);
    return Card(
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        child: Column(
          children: [
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(nomeDestinatario),
                  ],
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(valor),
                  ],
                ),
              ),
              leading: Text(vencimento),
              contentPadding: EdgeInsets.only(top: 15, bottom: 5, left: 10),
              onTap: () => Get.toNamed(
                  AppRoutes.Charges.chargeDetailsURLBuild(
                      tipoBook: EnumBookType.B_101,
                      tipoCobranca: EnumChargeType.C_111,
                      bookId: bookId,
                      chargeId: charge111Model.id),
                  arguments: charge111Model),
            ),
            Divider(indent: 10, endIndent: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ChargeStatusChipWidget(chargeStatus: this.charge111Model.status),
              ],
            ),
          ],
        ));
  }
}
