import 'package:get/get.dart';
import 'package:paybook_app/services/book_service.dart';

import '../usuario/user_controller.dart';
import 'home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController(userController: Get.find<UserController>(), bookService: BookService()));
  }
}
