import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/book_abstract_base_model.dart';
import '../../data/models/book_101_model.dart';
import '../../data/models/book_store_model.dart';
import '../../data/repositories/book_repository.dart';
import '../books/abstract_book_list.dart';
import '../books/book_101/book_simples_list_page.dart';
import '../usuario/user_controller.dart';

class HomeController extends GetxController {
  UserController _userController;
  BookRepository _bookRepository;
  var _currentBookId = ''.obs;
  BookAbstractBaseModel currentBook;
  final bookListObs = AbstractBookList().obs;

  RxList<BookStoreModel> _bookList = List<BookStoreModel>().obs;

  HomeController({@required UserController userController, @required BookRepository bookRepository}) {
    assert(userController != null);
    assert(bookRepository != null);
    this._userController = userController;
    this._bookRepository = bookRepository;
  }

  @override
  void onInit() {
    super.onInit();
    // qnd usuario estiver carregado, faço o init da home
    ever(_userController.rxUser, (user) {
      if (user != null) _doInit();
    });
  }

  /// define um novo book a ser mostrado na home
  changeBook(String bookId) {
    if (_bookList.map((book) => book.idBook).contains(bookId)) {
      _currentBookId.value = bookId;
      SharedPreferences.getInstance().then((sp) => sp.setString('currentBookId', currentBookId.value));
    }
  }

  /// recarrega o book atualmente aberto.
  ///
  /// executa apenas se o ID do book passado eh o mesmo do book corrente.
  reloadBook(String bookId) {
    if (_currentBookId.value == bookId) {
      // se realmente é o book corrente, seto para null e em seguida para o bookId
      // desta forma forço o ever(_currentBookId) a executar
      _currentBookId.value = null;
      _currentBookId.value = bookId;
    }
  }

  get currentBookId => this._currentBookId;

  RxList<BookStoreModel> get bookList => _bookList;

  /// init da home
  void _doInit() {
    // crio stream para a lista de books do usuario
    _bookList.bindStream(this._bookRepository.list(_userController.user.idUsuario));

    // trato a alteracao do book apresentado na home
    ever(_currentBookId, currentBookChangeHandler);

    // na inicializacao do app, qnd o bind do _booList for concluido, carrego o book inicial
    once(_bookList, (_) => SharedPreferences.getInstance().then((sp) => changeBook(sp.getString('currentBookId'))));

// faz a solicitacao das permissoes necessarias para utilizacao do aplicativo
    checkPermissions();
  }

  currentBookChangeHandler(bookId) {
    bookListObs.value = AbstractBookList();
    this._bookRepository.getByBookId(currentBookId.value).then((book) {
      var bookSimplesModel = Book101Model.fromBookStoreModel(book);
      bookListObs.value = BookSimplesListPage(bookSimplesModel);
    });
  }

  void novaCobranca() {
    bookListObs.value.novaCobranca();
  }

  checkPermissions() {
    Permission.contacts.status.then((permission) {
      if (permission != PermissionStatus.granted) {
        Permission.contacts.request().then((status) => print(status));
      }
    });
  }
}
