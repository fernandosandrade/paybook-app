import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import 'enum_tipo_de_book.dart';

/// apresenta os tipos de ook possiveis ao usuario.
///
/// identificando o desejado, o usuario seleciona o tipo de book, e é direcionado para a pagina de criacao do mesmo.
class NovoBookPage extends StatelessWidget {
  static const Map<EnumTipoDeBook, Widget> listasDeCobranca = {
    EnumTipoDeBook.SIMPLES: Text('nova lista de cobranca simples'),
    EnumTipoDeBook.RECORRENTE_COM_VALOR_BASE: Text('lista de cobranca recorrente'),
    EnumTipoDeBook.RATEIO: Text('lista de cobranca por rateio'),
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
                      RaisedButton(
                          child: Text("criar!"),
                          onPressed: () => criarListaDeCobranca(listasDeCobranca.entries
                              .elementAt(DefaultTabController.of(context).index)
                              .key))
                    ],
                  ),
                )));
  }

  Future<void> criarListaDeCobranca(EnumTipoDeBook tipoBook) async {
    switch (tipoBook) {
      case EnumTipoDeBook.SIMPLES:
        Get.toNamed(AppRoutes.BOOK_SIMPLES_FORM);
        break;
      case EnumTipoDeBook.RECORRENTE_COM_VALOR_BASE:
        print('recorrente');
        break;
      case EnumTipoDeBook.RATEIO:
        print('rateio');
        break;
      default:
    }
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
