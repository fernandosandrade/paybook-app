import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paybook_app/data/models/book/book_base_model.dart';
import 'package:paybook_app/routes/app_pages.dart';
import 'package:paybook_app/themes/default_icons.dart';

import 'home_controller.dart';

class HomePageHeaderWidget extends StatelessWidget {
  final String bookID;

  final String nomeBook;

  final int totalCobrancas;

  final double valorTotal;

  HomePageHeaderWidget(
      {required this.bookID, required this.nomeBook, required this.totalCobrancas, required this.valorTotal});

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
        IconButton(
            icon: Icon(
              DefaultIcons.EDIT_1,
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
          Text('$totalCobrancas cobranças', style: TextStyle(color: Colors.white, fontSize: 20)),
          SizedBox(height: 10),
          Text('R\$ ${formatter.format(valorTotal)}', style: TextStyle(color: Colors.white, fontSize: 20)),
        ],
      ),
    );
  }

  void _editarBook() {
    Get.toNamed(AppRoutes.BOOK_SIMPLES_FORM + '?id_book=' + this.bookID)!
        .then((_) => Get.find<HomeController>().reloadBook(this.bookID));
  }
}
