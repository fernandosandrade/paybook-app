import 'package:get/get.dart';
import 'package:logging/logging.dart';
import 'package:paybook_app/data/models/book/book_101_model.dart';
import 'package:paybook_app/data/models/charge/charge_111_model.dart';
import 'package:paybook_app/services/book_service.dart';
import 'package:paybook_app/services/charge_service.dart';

class Book101HomeController extends GetxController {
  final log = Logger('Book101Controller');

  final String bookId;

  final isLoading = false.obs;

  final _book101modelStream = Rxn<Book101Model>();

  final _chargesListStream = <Charge111Model?>[].obs;

  final BookService<Book101Model> bookService;

  final ChargeService<Charge111Model> cobrancaService;

  Book101HomeController(
      {required this.cobrancaService, required this.bookId, required this.bookService});

  // : this.cobrancaService = CobrancaService(
  //       book: EnumTipoBook.B_101,
  //       cobranca: EnumTipoCobranca.C_111,
  //       serializer: Charge111Model.serializer),
  //   this.bookId = Get.parameters[AppRoutes.Books.parameterBookId];

  @override
  void onReady() {
    log.info('new instance. AppRoutes.parameter_book_id[${this.bookId}]');

    _chargesListStream.bindStream(this.cobrancaService.listAll());

    // _book101modelStream.bindStream(Stream.fromFuture(bookService.getById(this.bookId)));

    loadBook();
    // change(null, status: RxStatus.loading());
    // if (this.bookId != null) {
    //   try {
    //     var findByBookId = this.cobrancaService.findByBookId(this.bookId!);
    //     print(findByBookId);
    //     change(findByBookId, status: RxStatus.success());
    //   } on Exception catch (e) {
    //     change(null, status: RxStatus.error(e.toString()));
    //   }
    // }
  }

  RxList<Charge111Model?> get chargesListStream => this._chargesListStream;

  Rxn<Book101Model> get book101modelStream => this._book101modelStream;

  int get totalCobrancas => this._chargesListStream.length;

  int get totalValue => this._chargesListStream.isEmpty
      ? 0
      : List<Charge111Model>.from(this._chargesListStream)
          .map((e) => e.amount)
          .reduce((value, element) => value + element)
          .toInt();

  loadBook() {
    this.isLoading.value = true;
    bookService.getById(this.bookId).then((book) {
      if (book != null) {
        this._book101modelStream.value = book;
      } else
        log.warning('no book was found for bookId=[$bookId]');
      this.isLoading.value = false;
    });
  }

  deleteBook() {
    assert(this._book101modelStream.value != null);
    this.isLoading.value = true;
    bookService.delete(this._book101modelStream.value!).then((_) {
      // log.warning('no book was found for bookId=[$bookId]');
      this.isLoading.value = false;
    });
  }
}
