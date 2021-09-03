import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paybook_app/data/models/book/book_101_model.dart';
import 'package:paybook_app/globals/enum_form_action.dart';
import 'package:paybook_app/modules/usuario/user_controller.dart';
import 'package:paybook_app/services/book_service.dart';
import 'package:paybook_app/services/enum_book_type.dart';
import 'package:paybook_app/utils/id_generator.dart';

class Book101FormController extends GetxController {
  final IBookService<Book101Model> bookService;
  final UserController userController;
  final _formKey = GlobalKey<FormState>();
  final _nomeBookTextController = TextEditingController();

  late EnumFormAction formAction;
  late String nomeBotao;
  late String tituloForm;

  var isInAsyncCall = false.obs;

  Book101Model? _bookToEdit;

  Book101FormController(
      {required this.bookService, required this.userController, Book101Model? bookToEdit})
      : this._bookToEdit = bookToEdit {
    _init();
  }

  _init() {
    this._bookToEdit == null ? _initFormIncluir() : _initFormAlterar(this._bookToEdit!);
  }

  Book101Model? get bookModel => this._bookToEdit;

  get formKey => this._formKey;

  get nomeBookTextController => this._nomeBookTextController;

  Future<String> salvarBook() async {
    _formKey.currentState!.save();

    assert(userController.user != null);

    if (formAction == EnumFormAction.INCLUIR) {
      return _include();
    } else if (formAction == EnumFormAction.ALTERAR) {
      return _update();
    }
    throw Exception('form action not defined');
  }

  String _include() {
    var book101Model = Book101Model((s) => s
      ..id = IdGenerator.randomAlphanumeric()
      ..name = _nomeBookTextController.value.text
      ..bookType = EnumBookType.B_101
      ..active = true
      ..creationDate = DateTime.now().toUtc());
    // book101Model.vencimento = DateTime.now().add(Duration(days: 1)).millisecondsSinceEpoch;
    //print('${novoBook.toJson()}');
    // bookStoreModel = BookStoreModel.fromAbstractBaseModel(book101Model);
    bookService.save(book101Model);
    this._bookToEdit = book101Model;
    return 'book ${book101Model.name} criado com sucesso.';
  }

  String _update() {
    var book101Model =
        this._bookToEdit!.rebuild((s) => s..name = _nomeBookTextController.value.text);
    bookService.save(book101Model);
    this._bookToEdit = book101Model;
    return 'book ${book101Model.name} alterado com sucesso.';
  }

  _initFormIncluir() {
    this.formAction = EnumFormAction.INCLUIR;
    this.tituloForm = 'novo book simples';
    this.nomeBotao = 'criar!';
    // this.isInAsyncCall.value = false;
  }

  _initFormAlterar(Book101Model book) {
    this.formAction = EnumFormAction.ALTERAR;
    this.tituloForm = 'alterar book simples';
    this.nomeBotao = 'alterar!';
    this._nomeBookTextController.text = book.name;
    // this.isInAsyncCall.value = true;
    // bookService.getById(idBook).then((bookStoreModel) {
    //   this._bookStoreModel = bookStoreModel;
    //
    //   this._nomeBookTextController.text = bookStoreModel.nomeBook;
    // }).whenComplete(() => this.isInAsyncCall.value = false);
  }
}
