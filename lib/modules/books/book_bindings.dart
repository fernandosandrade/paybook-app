import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../services/book_service.dart';
import 'book_controller.dart';

class BookBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookController>(() => BookController(bookRepository: BookRepository(firestore: Firestore.instance)));
  }
}
