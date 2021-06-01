import 'package:get/get.dart';
import 'package:paybook_app/routes/app_pages.dart';

class Book101Controller extends GetxController {
  @override
  void onReady() {
    var parameter = Get.parameters[AppRoutes.parameter_book_id];
    print('nova instancia => $parameter');
  }
}
