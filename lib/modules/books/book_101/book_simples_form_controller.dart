import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/book_101_model.dart';
import '../../../data/models/book_store_model.dart';
import '../../../services/book_service.dart';
import '../../../globals/enum_form_action.dart';
import '../../../utils/id_generator.dart';
import '../../usuario/user_controller.dart';

class BookSimplesFormController extends GetxController {
  final IBookRepository bookRepository;
  BookStoreModel _bookStoreModel;
  final userController = Get.find<UserController>();

  final _formKey = GlobalKey<FormState>();
  final _nomeBookTextController = TextEditingController();

// observaveis
  final tituloForm = ''.obs;
  var formAction = EnumFormAction.INDEFINIDA.obs;
  var isInAsyncCall = false.obs;
  var nomeBotao = ''.obs;

  BookSimplesFormController({required this.bookRepository});

  @override
  onInit() {
    Get.parameters.containsKey('id_book') ? _initFormAlterar(Get.parameters['id_book']) : _initFormIncluir();
  }

  get formKey => this._formKey;

  get nomeBookTextController => this._nomeBookTextController;

  Future<String> salvarBook() async {
    _formKey.currentState.save();

    assert(userController != null);
    assert(userController.user != null);
    assert(userController.user.idUsuario != null);
    assert(_nomeBookTextController.value != null);

    BookStoreModel bookStoreModel;
    String msgRetorno;
    if (formAction.value == EnumFormAction.INCLUIR) {
      Book101Model book101Model = Book101Model(
          idBook: IdGenerator.randomAlphanumeric(),
          idUsuario: userController.user.idUsuario,
          nomeBook: _nomeBookTextController.value.text);
      //book101Model.vencimento = DateTime.now().add(Duration(days: 1)).millisecondsSinceEpoch;
      //print('${novoBook.toJson()}');
      bookStoreModel = BookStoreModel.fromAbstractBaseModel(book101Model);
      msgRetorno = 'book ${book101Model.nomeBook} criado com sucesso.';
    }
    if (formAction.value == EnumFormAction.ALTERAR) {
      this._bookStoreModel.nomeBook = _nomeBookTextController.value.text;
      bookStoreModel = this._bookStoreModel;
      msgRetorno = 'book ${bookStoreModel.nomeBook} alterado com sucesso.';
    }
    bookRepository.save(bookStoreModel);
    return msgRetorno;
  }

  _initFormIncluir() {
    formAction.value = EnumFormAction.INCLUIR;
    this.tituloForm.value = 'novo book simples';
    this.nomeBotao.value = 'criar!';
    this.isInAsyncCall.value = false;
  }

  _initFormAlterar(String idBook) {
    formAction.value = EnumFormAction.ALTERAR;
    this.tituloForm.value = 'alterar book simples';
    this.nomeBotao.value = 'alterar!';
    this.isInAsyncCall.value = true;
    bookRepository.getByBookId(idBook).then((bookStoreModel) {
      this._bookStoreModel = bookStoreModel;

      this._nomeBookTextController.text = bookStoreModel.nomeBook;
    }).whenComplete(() => this.isInAsyncCall.value = false);
  }
}
