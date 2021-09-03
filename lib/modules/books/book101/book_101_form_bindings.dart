import 'package:get/get.dart';
import 'package:paybook_app/data/collections/books_collection.dart';
import 'package:paybook_app/data/models/book/book_101_model.dart';
import 'package:paybook_app/modules/usuario/user_controller.dart';
import 'package:paybook_app/routes/app_pages.dart';
import 'package:paybook_app/services/book_service.dart';

import 'book_101_form_controller.dart';

class Book101FormBinding implements Bindings {
  @override
  void dependencies() {
    Book101Model? bookModel;
    var bookId = Get.parameters[AppRoutes.Books.parameterBookId];

    if (bookId != null) {
      bookModel = Get.arguments;
    }

    UserController userController = Get.find<UserController>();
    assert(userController.user != null);

    BooksCollection booksCollection = BooksCollection(userId: userController.user!.id);

    Get.lazyPut<Book101FormController>(() => Book101FormController(
        bookService:
            BookService(booksCollection: booksCollection, serializer: Book101Model.serializer),
        userController: Get.find<UserController>(),
        bookToEdit: bookModel));
  }
}
