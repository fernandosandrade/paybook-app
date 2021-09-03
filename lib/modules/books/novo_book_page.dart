import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paybook_app/data/models/book/abstract_book_base_model.dart';
import 'package:paybook_app/data/models/book/book_basic_model.dart';
import 'package:paybook_app/services/enum_book_type.dart';

import '../../routes/app_pages.dart';

/// apresenta os tipos de ook possiveis ao usuario.
///
/// identificando o desejado, o usuario seleciona o tipo de book, e é direcionado para a pagina de criacao do mesmo.
class NovoBookPage extends StatelessWidget {
  static const Map<EnumBookType, Widget> listasDeCobranca = {
    EnumBookType.B_101: Text('nova lista de cobranca simples'),
    EnumBookType.B_201: Text('lista de cobranca recorrente'),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('novo book')),
      body: Container(child: _content()),
    );
  }

  Widget _content() {
    return DefaultTabController(
        length: listasDeCobranca.length,
        child: Builder(
            builder: (BuildContext context) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TabPageSelector(),
                      Expanded(
                          child: TabBarView(
                              children: listasDeCobranca.values.map((e) {
                        return Center(child: e);
                      }).toList())),
                      ElevatedButton(
                          child: Text("criar!"),
                          onPressed: () => criarBook(listasDeCobranca.entries
                              .elementAt(DefaultTabController.of(context)!.index)
                              .key))
                    ],
                  ),
                )));
  }

  Future<void> criarBook(EnumBookType tipoBook) async {
    Future? future;
    switch (tipoBook) {
      case EnumBookType.B_101:
        future = Get.toNamed(AppRoutes.Books.newBook101FormURLTemplate);
        break;
      case EnumBookType.B_201:
        Get.toNamed(AppRoutes.Books.newBook201FormURLTemplate);
        break;
      default:
    }
    assert(future != null);
    // if (future != null) {
    future!.then((bookId) {
      assert(bookId != null);
      Get.back(result: bookId);
    });
    // }
  }

/*
  Future<String> novoBookCobrancaSimples(UsuarioController userController) async {
    assert(userController != null);
    assert(userController.user != null);
    assert(userController.user.idUsuario != null);
    log('cobranca simples');
    var nomeBook = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => NovoBookCobrancaSimplesPage()));
    if (nomeBook == null) {
      return null;
    }
    BookCobrancaSimplesModel novoBook =
        BookCobrancaSimplesModel(idUsuario: userController.user.idUsuario, nomeBook: nomeBook);
    novoBook.vencimento = DateTime.now().add(Duration(days: 1)).millisecondsSinceEpoch;
    print('${novoBook.toJson()}');
    controller.save(novoBook);
    return nomeBook;
  }

  void _retornar() {
    Get.back();
  }
  */
}
