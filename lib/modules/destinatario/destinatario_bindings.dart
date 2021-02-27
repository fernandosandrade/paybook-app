import 'package:get/get.dart';

import 'destinatario_controller.dart';

class DestinatarioBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<DestinatarioController>(DestinatarioController());
  }
}
