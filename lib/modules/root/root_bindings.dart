import 'package:get/get.dart';
import 'package:paybook_app/services/users_service.dart';

import '../auth/auth_controller.dart';
import '../../services/auth_service.dart';
import '../usuario/user_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(authService: Get.put(AuthService())), permanent: true);
    Get.put<UserController>(
        UserController(authController: Get.find<AuthController>(), userService: Get.put(UserService())),
        permanent: true);
  }
}
