import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paybook_app/data/models/book/abstract_book_base_model.dart';
import 'package:paybook_app/routes/app_pages.dart';
import 'package:paybook_app/services/enum_book_type.dart';
import 'package:paybook_app/themes/default_icons.dart';
import 'package:paybook_app/utils/formatters.dart';

import 'home_controller.dart';

enum _BookMenuOptions { edit, delete }

class HomePageHeaderWidget extends StatelessWidget {
  final String bookID;

  final EnumBookType tipoBook;

  final String nomeBook;

  final int totalCobrancas;

  final int valorTotal;

  final Function editBook;

  final Function deleteBook;

  HomePageHeaderWidget(
      {required this.bookID,
      required this.tipoBook,
      required this.nomeBook,
      required this.totalCobrancas,
      required this.valorTotal,
      required this.editBook,
      required this.deleteBook});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        automaticallyImplyLeading: false,
        title: _appBarTitle(),
        pinned: true,
        expandedHeight: 150.0,
        flexibleSpace: FlexibleSpaceBar(
          background: _appBarHeader(),
        ));
  }

  Widget _appBarTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('$nomeBook'),
        PopupMenuButton(
          itemBuilder: (_) => [
            const PopupMenuItem(
              value: _BookMenuOptions.edit,
              child: Text('editar'),
            ),
            const PopupMenuItem(
              value: _BookMenuOptions.delete,
              child: Text('excluir'),
            ),
          ],
          onSelected: (_BookMenuOptions option) => _popupMenuActions(option),
        ),
      ],
    );
  }

  Widget _appBarHeader() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text('$totalCobrancas cobranças', style: TextStyle(color: Colors.white, fontSize: 20)),
          SizedBox(height: 10),
          Text('R\$ ${Formatters.currencyPtBr(valorTotal)}',
              style: TextStyle(color: Colors.white, fontSize: 20)),
        ],
      ),
    );
  }

  _popupMenuActions(_BookMenuOptions? option) {
    switch (option) {
      case _BookMenuOptions.edit:
        editBook();
        break;
      case _BookMenuOptions.delete:
        deleteBook();
        break;
      default:
    }
  }
}
