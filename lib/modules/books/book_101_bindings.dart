import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paybook_app/data/models/book/book_101_model.dart';
import 'package:paybook_app/data/models/charge/charge_111_model.dart';
import 'package:paybook_app/globals/preconditions.dart';
import 'package:paybook_app/routes/app_pages.dart';
import 'package:paybook_app/services/book_service.dart';
import 'package:paybook_app/services/cobranca_service.dart';
import 'package:paybook_app/services/enum_tipo_book.dart';
import 'package:paybook_app/services/enum_tipo_cobranca.dart';

import 'book_101_controller.dart';

class Book101Bindings implements Bindings {
  @override
  void dependencies() {
    var bookId = Preconditions.checkNotNull(
        Get.parameters[AppRoutes.Books.parameterBookId], 'nenhum book definido');

    var cobrancaService = CobrancaService(
        book: EnumTipoBook.B_101,
        cobranca: EnumTipoCobranca.C_111,
        serializer: Charge111Model.serializer);
    // insert controller
    Get.put(
        Book101Controller(
            cobrancaService: cobrancaService,
            bookId: bookId,
            bookService: BookService(Book101Model.serializer)),
        tag: bookId);
  }
}
