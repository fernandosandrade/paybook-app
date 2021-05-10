import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:paybook_app/services/book_service.dart';

import 'book_simples_form_controller.dart';

class BookSimplesFormBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookSimplesFormController>(
        () => BookSimplesFormController(bookRepository: BookRepository(firestore: Firestore.instance)));
  }
}
