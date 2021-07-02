import 'package:get/get.dart';
import 'package:logging/logging.dart';
import 'package:paybook_app/data/models/book/book_101_model.dart';
import 'package:paybook_app/data/models/charge/charge_111_model.dart';
import 'package:paybook_app/services/book_service.dart';
import 'package:paybook_app/services/cobranca_service.dart';

class Book101Controller extends GetxController {
  final log = Logger('Book101Controller');

  final String bookId;

  final isLoading = true.obs;

  final book101modelStream = Rxn<Book101Model>();

  final _chargesListStream = <Charge111Model?>[].obs;

  final BookService<Book101Model> bookService;

  final CobrancaService<Charge111Model> cobrancaService;

  Book101Controller(
      {required this.cobrancaService, required this.bookId, required this.bookService});

  // : this.cobrancaService = CobrancaService(
  //       book: EnumTipoBook.B_101,
  //       cobranca: EnumTipoCobranca.C_111,
  //       serializer: Charge111Model.serializer),
  //   this.bookId = Get.parameters[AppRoutes.Books.parameterBookId];

  @override
  void onReady() {
    log.info('new instance. AppRoutes.parameter_book_id[${this.bookId}]');

    _chargesListStream.bindStream(this.cobrancaService.findByBookId(this.bookId));

    bookService.getById(this.bookId).then((book) {
      if (book != null) {
        this.book101modelStream.value = book;
      } else
        log.warning('no book was found for bookId=[$bookId]');
      this.isLoading.value = false;
    });
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

  int get totalCobrancas => this._chargesListStream.length;

  double get totalValue => this._chargesListStream.isEmpty
      ? 0.0
      : List<Charge111Model>.from(this._chargesListStream)
          .map((e) => e.valor)
          .reduce((value, element) => value + element)
          .toDouble();
}
