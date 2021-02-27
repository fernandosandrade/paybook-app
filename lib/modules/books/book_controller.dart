import 'dart:developer';

import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../data/models/book_abstract_base_model.dart';
import '../../data/models/book_store_model.dart';
import '../../data/repositories/book_repository.dart';

class BookController extends GetxController {
  /*final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;*/

  IBookRepository _bookRepository;

  RxList<BookStoreModel> bookList = List<BookStoreModel>().obs;

  BookController({@required IBookRepository bookRepository}) {
    this._bookRepository = bookRepository;
    //bookList.bindStream(this._bookRepository.list());
  }

  void save<T extends BookAbstractBaseModel>(T model) {
    var json = model.toJson();
    assert(model.idBook != null);
    assert(model.idUsuario != null);
    assert(model.tipoBook != null);
    assert(model.nomeBook != null);
    BookStoreModel storeModel = BookStoreModel(
        idBook: model.idBook,
        idUsuario: model.idUsuario,
        tipoBook: model.tipoBook,
        nomeBook: model.nomeBook);
    storeModel.atributos = json;
    log('gravando novo book [${storeModel.toJson}');
    this._bookRepository.save(storeModel);
  }
}
