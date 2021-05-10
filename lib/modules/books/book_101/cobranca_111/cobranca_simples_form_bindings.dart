import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../../services/cobranca_111_service.dart';
import 'cobranca_simples_form_controller.dart';

class CobrancaSimplesFormBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
        CobrancaSimplesFormController(cobrancaSimplesRepository: Cobranca111Service(firestore: Firestore.instance)));
  }
}
