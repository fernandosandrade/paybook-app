import 'package:logging/logging.dart';
import 'package:paybook_app/data/collections/books_collection.dart';
import 'package:paybook_app/routes/app_pages.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import 'package:paybook_app/services/book_service.dart';
import 'package:paybook_app/data/models/book/book_basic_model.dart';
import 'package:paybook_app/modules/usuario/user_controller.dart';

class HomeController extends GetxController {
  final log = Logger('HomeController');
  static const CURRENT_BOOK_ID_KEY = 'current_book_id';
  final UserController _userController;
  late BookService<BookBasicModel> _bookService;

  /// book list from logged user
  var _bookListStream = <BookBasicModel?>[].obs;

  /// current loaded book
  var _currentBookId = ''.obs;

  HomeController({required UserController userController}) : _userController = userController;
  // _bookService = bookService;

  @override
  void onInit() {
    super.onInit();
    log.info(
        'navegation parameter ${AppRoutes.Books.parameterBookId}=${Get.parameters[AppRoutes.Books.parameterBookId]}');
    // qnd usuario estiver carregado, faço o init da home
    ever(_userController.rxUser, (user) {
      if (user != null) _doInit();
    });
  }

  /// returns the current book id (matches the documentID)
  get currentBookId => this._currentBookId;

  /// returns a list stream containing the user's books
  RxList<BookBasicModel?> get bookListStream => _bookListStream;

  /// define um novo book a ser mostrado na home
  changeBook(String bookId) {
    log.info('change book to [$bookId]');
    if (_bookListStream.map((b) => b?.id).contains(bookId)) {
      var bookBasicModel = _bookListStream.singleWhere((e) => bookId == e!.id);
      _currentBookId.value = bookBasicModel!.id;
      SharedPreferences.getInstance().then((sp) => sp.setString(CURRENT_BOOK_ID_KEY, bookId));
      Get.currentRoute == AppRoutes.HOME
          ? Get.toNamed(AppRoutes.Books.homeBookURLBuild(
              tipoBook: bookBasicModel.bookType, bookID: bookBasicModel.id))
          : Get.offNamed(AppRoutes.Books.homeBookURLBuild(
              tipoBook: bookBasicModel.bookType, bookID: bookBasicModel.id));
    } else {
      log.severe('book not found. bookId=[$bookId]');
      if (_bookListStream.isNotEmpty) {
        changeBook(_bookListStream.elementAt(0)!.id);
      }
    }
  }

  /// recarrega o book atualmente aberto.
  ///
  /// executa apenas se o ID do book passado eh o mesmo do book corrente.
  reloadBook() {
    // if (_currentBookId.value == bookId) {
    // se realmente é o book corrente, seto para null e em seguida para o bookId
    // desta forma forço o ever(_currentBookId) a executar
    // _currentBookId.refresh();
    // _bookListStream.refresh();
    // log.info('reloading book. bookId=$_currentBookId');
    // _currentBookId.value = '';
    // _currentBookId.value = bookId;
  }
  // else {
  //   log.warning(
  //       'reloadBook called, but currentBookId is different from informed bookId. current=${_currentBookId.value} bookId=$bookId');
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
    // _bookListStream.bindStream(this._bookService.list(_userController.user?.id));

    BooksCollection booksCollection = BooksCollection(userId: _userController.user!.id);
    this._bookService =
        BookService(booksCollection: booksCollection, serializer: BookBasicModel.serializer);

    _bookListStream.bindStream(_userBooks());

    // na inicializacao do app, qnd o bind do _booList for concluido, carrego o book inicial
    once(
        _bookListStream,
        (_) => SharedPreferences.getInstance().then((sp) {
              var currentBookId = sp.getString(CURRENT_BOOK_ID_KEY);
              if (currentBookId != null) {
                log.info('loading initial book...');
                changeBook(currentBookId);
              } else {
                log.warning('no book in SharedPreferences');
              }
            }));

    // faz a solicitacao das permissoes necessarias para utilizacao do aplicativo
    checkPermissions();
  }

  /// return a stream o book for informed user. If ``userId == null``, return a [Stream.empty]
  Stream<List<BookBasicModel?>> _userBooks() {
    return this._bookService.listAllActives();
  }

  newBook() {
    Get.toNamed(AppRoutes.NOVO_BOOK)!.then((value) {
      changeBook(value);
    });
  }

// BookAbstractBaseModel currentBook;
// final bookListObs = AbstractBookList().obs;
//final _rxHomeContent = HomeContentDelegate.from(NoBookPage()).obs;
//
// currentBookChangeHandler(String bookID) {
//   Get.toNamed(AppRoutes.open_book_101_build(bookID: bookID));
// _rxHomeContent.value = HomeContentDelegate.from(LoadingBookPage());
// this._bookService.getById(currentBookId.value).then((book) {
//   _rxHomeContent.value = HomeContentDelegate.from(NoBookPage());
// });
// }
//
// currentBookChangeHandler(bookId) {
//   bookListObs.value = AbstractBookList();
//   this._bookRepository.getByBookId(currentBookId.value).then((book) {
//     var bookSimplesModel = Book101Model.fromBookStoreModel(book);
//     bookListObs.value = BookSimplesListPage(bookSimplesModel);
//   });
// }
//
// void novaCobranca() {
//   _rxHomeContent.value.fabDelegate();
// }
//
// void novaCobranca() {
//   bookListObs.value.novaCobranca();
// }
}
