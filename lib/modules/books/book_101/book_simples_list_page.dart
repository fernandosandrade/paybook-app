import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/models/book_101_model.dart';
import '../../../data/models/cobranca_101_model.dart';
import '../../../data/repositories/cobranca_simples_repository.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/default_icons.dart';
import '../../home/home_controller.dart';
import '../abstract_book_list.dart';
import 'book_simples_list_controller.dart';
import 'cobranca_111/card_cobranca_111.dart';

class BookSimplesListPage extends AbstractBookList {
  final BookSimplesListController bookController;

  BookSimplesListPage(Book101Model bookSimplesModel)
      : bookController = BookSimplesListController(
            cobrancaSimplesRepository: CobrancaSimplesRepository(firestore: Firestore.instance),
            bookSimplesModel: bookSimplesModel);

  @override
  Widget getBookList() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
            title: _appBarTitle(),
            pinned: true,
            expandedHeight: 150.0,
            flexibleSpace: FlexibleSpaceBar(
              background: _appBarHeader(),
            )),
        GetX<BookSimplesListController>(
            init: bookController,
            builder: (_) {
              if (_.cobrancaSimplesList == null) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                List<Cobranca101Model> list = _.cobrancaSimplesList.value;
                if (list.isNotEmpty) {
                  return SliverList(
                      delegate: SliverChildBuilderDelegate((_, index) {
                    return CardCobranca111(
                      cobrancaSimplesModel: list[index],
                    );
                  }, childCount: _.totalCobrancas));
                } else {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text('nenhuma cobrança neste book'),
                    ),
                  );
                }
              }
            }),
      ],
    );
  }

  @override
  void novaCobranca() {
    //Get.toNamed(AppRoutes.COBRANCA_SIMPLES_FORM);
    Get.toNamed(AppRoutes.SELETOR_COBRANCA_BOOK_101);
  }

  Widget _appBarTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('${bookController.bookSimplesModel.nomeBook}'),
        IconButton(
            icon: Icon(
              DefaultIcons.ICONE_EDITAR_1,
              color: Colors.white,
            ),
            onPressed: () => _editarBook())
      ],
    );
  }

  Widget _appBarHeader() {
    final formatter = new NumberFormat("#,##0.00", "pt_BR");
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Obx(() => Text('${bookController.totalCobrancas} cobranças',
              style: TextStyle(color: Colors.white, fontSize: 20))),
          SizedBox(height: 10),
          Obx(() => Text('R\$ ${formatter.format(bookController.valorTotal)}',
              style: TextStyle(color: Colors.white, fontSize: 20))),
        ],
      ),
    );
  }

  void _editarBook() {
    Get.toNamed(AppRoutes.BOOK_SIMPLES_FORM + '?id_book=' + bookController.bookSimplesModel.idBook)
        .then((_) => Get.find<HomeController>().reloadBook(bookController.bookSimplesModel.idBook));
  }
}
