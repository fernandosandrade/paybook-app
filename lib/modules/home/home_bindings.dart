import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../services/book_service.dart';
import '../usuario/user_controller.dart';
import 'home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController(
        userController: Get.find<UserController>(), bookRepository: BookRepository(firestore: Firestore.instance)));
  }
}
