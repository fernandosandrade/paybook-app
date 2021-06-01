import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';
import 'package:paybook_app/globals/serializers.dart';
import 'package:paybook_app/routes/app_pages.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import 'package:paybook_app/services/book_service.dart';
import 'package:paybook_app/data/models/book/book_basic_model.dart';
import 'package:paybook_app/modules/books/no_book_page.dart';
import 'package:paybook_app/modules/usuario/user_controller.dart';

import 'home_content_delegate.dart';

class HomeController extends GetxController {
  final log = Logger('HomeController');
  static const CURRENT_BOOK_KEY = 'current_book';
  final UserController _userController;
  final BookService _bookService;

  var _currentBookId = ''.obs;

  // BookAbstractBaseModel currentBook;
  // final bookListObs = AbstractBookList().obs;
  final _rxHomeContent = HomeContentDelegate.from(NoBookPage()).obs;
  var _bookList = <BookBasicModel?>[].obs;

  HomeController({required UserController userController, required BookService bookService})
      : _userController = userController,
        _bookService = bookService;

  @override
  void onInit() {
    super.onInit();
    log.info(Get.parameters[AppRoutes.parameter_book_id]);
    // qnd usuario estiver carregado, faço o init da home
    ever(_userController.rxUser, (user) {
      if (user != null) _doInit();
    });
  }

  /// return home content
  Widget homeContent() => _rxHomeContent.value.content();

  /// returns the current book id (matches the documentID)
  get currentBookId => this._currentBookId;

  /// returns a list stream containing the user's books
  RxList<BookBasicModel?> get bookList => _bookList;

  /// define um novo book a ser mostrado na home
  changeBook(BookBasicModel? book) {
    if (book != null) {
      log.info('change book to [$book]');
      if (_bookList.map((b) => b?.documentID).contains(book.documentID)) {
        _currentBookId.value = book.documentID;
        SharedPreferences.getInstance().then((sp) => sp.setString(CURRENT_BOOK_KEY, json.encode(book.toMap())));
        Get.currentRoute == AppRoutes.HOME
            ? Get.toNamed(AppRoutes.homeBookBuild(tipoBook: book.tipoBook, bookID: book.documentID))
            : Get.offNamed(AppRoutes.homeBookBuild(tipoBook: book.tipoBook, bookID: book.documentID));
      }
    }
  }

  /// recarrega o book atualmente aberto.
  ///
  /// executa apenas se o ID do book passado eh o mesmo do book corrente.
  reloadBook(String bookId) {
    if (_currentBookId.value == bookId) {
      // se realmente é o book corrente, seto para null e em seguida para o bookId
      // desta forma forço o ever(_currentBookId) a executar
      _currentBookId.value = '';
      _currentBookId.value = bookId;
    }
  }

  // currentBookChangeHandler(String bookID) {
  //   Get.toNamed(AppRoutes.open_book_101_build(bookID: bookID));
  // _rxHomeContent.value = HomeContentDelegate.from(LoadingBookPage());
  // this._bookService.getById(currentBookId.value).then((book) {
  //   _rxHomeContent.value = HomeContentDelegate.from(NoBookPage());
  // });
  // }

  // currentBookChangeHandler(bookId) {
  //   bookListObs.value = AbstractBookList();
  //   this._bookRepository.getByBookId(currentBookId.value).then((book) {
  //     var bookSimplesModel = Book101Model.fromBookStoreModel(book);
  //     bookListObs.value = BookSimplesListPage(bookSimplesModel);
  //   });
  // }

  void novaCobranca() {
    _rxHomeContent.value.fabDelegate();
  }

  // void novaCobranca() {
  //   bookListObs.value.novaCobranca();
  // }

  checkPermissions() {
    Permission.contacts.status.then((permission) {
      if (permission != PermissionStatus.granted) {
        Permission.contacts.request().then((status) => print(status));
      }
    });
  }

  /// home initialization.
  ///
  /// makes the necessary binds for the functioning of the home screen.
  void _doInit() {
    // crio stream para a lista de books do usuario
    _bookList.bindStream(this._bookService.list(_userController.user?.documentID));

    // trato a alteracao do book apresentado na home
    // ever(_currentBookId, currentBookChangeHandler);

    // na inicializacao do app, qnd o bind do _booList for concluido, carrego o book inicial
    once(
        _bookList,
        (_) => SharedPreferences.getInstance().then((sp) {
              var currentBookJson = sp.getString(CURRENT_BOOK_KEY);
              if (currentBookJson != null) {
                log.info('loading initial book...');
                changeBook(serializers.fromJson(BookBasicModel.serializer, currentBookJson));
              } else {
                log.warning('no book in SharedPreferences');
              }
            }));

    // faz a solicitacao das permissoes necessarias para utilizacao do aplicativo
    checkPermissions();
  }
}
