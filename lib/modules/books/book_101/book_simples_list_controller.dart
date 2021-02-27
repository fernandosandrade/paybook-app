import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../../data/models/book_101_model.dart';
import '../../../data/models/cobranca_101_model.dart';
import '../../../data/repositories/cobranca_simples_repository.dart';

class BookSimplesListController extends GetxController {
  ICobrancaSimplesRepository _cobrancaSimplesRepository;
  Book101Model _bookSimplesModel;
  RxList<Cobranca101Model> _cobrancaSimplesList = List<Cobranca101Model>().obs;

  BookSimplesListController(
      {@required ICobrancaSimplesRepository cobrancaSimplesRepository,
      @required Book101Model bookSimplesModel}) {
    assert(cobrancaSimplesRepository != null);
    assert(bookSimplesModel != null);
    this._cobrancaSimplesRepository = cobrancaSimplesRepository;
    this._bookSimplesModel = bookSimplesModel;
    _cobrancaSimplesList
        .bindStream(_cobrancaSimplesRepository.listByBookId(_bookSimplesModel.idBook));
  }

  Book101Model get bookSimplesModel => this._bookSimplesModel;

  void refresh() => _cobrancaSimplesList
      .bindStream(_cobrancaSimplesRepository.listByBookId(_bookSimplesModel.idBook));

  RxList<Cobranca101Model> get cobrancaSimplesList => this._cobrancaSimplesList;

  int get totalCobrancas => this._cobrancaSimplesList.value?.length;

  double get valorTotal => _cobrancaSimplesList.isEmpty
      ? 0.0
      : List<Cobranca101Model>.from(_cobrancaSimplesList)
          .map((e) => e.valor)
          .reduce((value, element) => value + element)
          .toDouble();
}
