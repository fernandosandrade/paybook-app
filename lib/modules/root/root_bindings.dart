import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../data/repositories/users_repository.dart';
import '../auth/auth_controller.dart';
import '../auth/auth_service.dart';
import '../usuario/user_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(authService: Get.put(AuthService())), permanent: true);
    Get.put<UserController>(
        UserController(
            authController: Get.find<AuthController>(),
            usersRepository: Get.put(UsersRepository(firestore: Firestore.instance))),
        permanent: true);
  }
}
