import 'package:get/get.dart';
import 'package:paybook_app/data/collections/books_collection.dart';
import 'package:paybook_app/data/collections/charges_collection.dart';
import 'package:paybook_app/data/models/book/book_101_model.dart';
import 'package:paybook_app/data/models/charge/charge_111_model.dart';
import 'package:paybook_app/globals/preconditions.dart';
import 'package:paybook_app/modules/usuario/user_controller.dart';
import 'package:paybook_app/routes/app_pages.dart';
import 'package:paybook_app/services/book_service.dart';
import 'package:paybook_app/services/charge_service.dart';

import 'book_101_controller.dart';

class Book101Bindings implements Bindings {
  @override
  void dependencies() {
    var bookId = Preconditions.checkNotNull(
        Get.parameters[AppRoutes.Books.parameterBookId], 'nenhum book definido');

    UserController userController = Get.find<UserController>();
    assert(userController.user != null);
    BooksCollection booksCollection = BooksCollection(userId: userController.user!.id);

    var chargesCollection = ChargesCollection(userId: userController.user!.id, bookId: bookId);
    var cobrancaService =
        ChargeService(chargesCollection: chargesCollection, serializer: Charge111Model.serializer);

    // insert controller
    Get.put(
        Book101Controller(
            cobrancaService: cobrancaService,
            bookId: bookId,
            bookService:
                BookService(booksCollection: booksCollection, serializer: Book101Model.serializer)),
        tag: bookId);
  }
}
