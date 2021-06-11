import 'package:get/get.dart';
import 'package:logging/logging.dart';
import 'package:paybook_app/routes/app_pages.dart';

class Book201Controller extends GetxController {
  final log = Logger('Book201Controller');

  @override
  void onReady() {
    var parameter = Get.parameters[AppRoutes.parameter_book_id];
    log.info('nova instancia => $parameter');
  }
}
