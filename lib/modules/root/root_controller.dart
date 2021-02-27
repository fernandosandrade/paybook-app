import 'package:get/get.dart';

class RootController extends GetxController {
  /*final MyRepository repository;
  RootController({@required this.repository}) : assert(repository != null);*/

  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;

  /*@override
  void onReady() {
    ever(
        Get.find<AuthController>().status,
        (_) =>
            _ != AuthStatus.LOGGED_IN ? Get.toNamed(AppRoutes.HOME) : Get.toNamed(AppRoutes.LOGIN));
    super.onInit();
  }*/
}
