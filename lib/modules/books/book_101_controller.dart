import 'package:get/get.dart';
import 'package:logging/logging.dart';
import 'package:paybook_app/data/models/cobranca/cobranca_111_model.dart';
import 'package:paybook_app/routes/app_pages.dart';
import 'package:paybook_app/services/cobranca_service.dart';
import 'package:paybook_app/services/enum_tipo_book.dart';
import 'package:paybook_app/services/enum_tipo_cobranca.dart';

class Book101Controller extends GetxController {
  final log = Logger('Book101Controller');

  final String? bookId;

  final CobrancaService<Cobranca111Model> cobrancaService;

  final _chargesList = <Cobranca111Model?>[].obs;

  Book101Controller()
      : this.cobrancaService = CobrancaService(
            book: EnumTipoBook.B_101, cobranca: EnumTipoCobranca.C_111, serializer: Cobranca111Model.serializer),
        this.bookId = Get.parameters[AppRoutes.parameter_book_id];

  @override
  void onReady() {
    var parameter = Get.parameters[AppRoutes.parameter_book_id];
    log.info('new instance. AppRoutes.parameter_book_id[$parameter]');

    _chargesList.bindStream(this.cobrancaService.findByBookId(this.bookId!));
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

  RxList<Cobranca111Model?> get chargesStream => this._chargesList;

  int? get totalCobrancas => this._chargesList.value?.length;
}
