import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../data/repositories/book_repository.dart';
import 'book_controller.dart';

class BookBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookController>(
        () => BookController(bookRepository: BookRepository(firestore: Firestore.instance)));
  }
}
