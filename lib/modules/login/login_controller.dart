import 'package:get/get.dart';
import 'package:meta/meta.dart';

class LoginController extends GetxController {
//final MyRepository repository;
//LoginController({required this.repository}) : assert(repository != null);

// manage state of modal progress HUD widget
  var isInAsyncCall = false.obs;

  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
}
