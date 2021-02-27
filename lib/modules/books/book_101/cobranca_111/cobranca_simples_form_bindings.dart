import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/cobranca_simples_repository.dart';
import 'cobranca_simples_form_controller.dart';

class CobrancaSimplesFormBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CobrancaSimplesFormController(
        cobrancaSimplesRepository: CobrancaSimplesRepository(firestore: Firestore.instance)));
  }
}
