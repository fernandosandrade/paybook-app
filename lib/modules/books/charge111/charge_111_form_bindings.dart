import 'package:get/get.dart';
import 'package:paybook_app/data/collections/charges_collection.dart';
import 'package:paybook_app/data/models/charge/charge_111_model.dart';
import 'package:paybook_app/globals/preconditions.dart';
import 'package:paybook_app/modules/usuario/user_controller.dart';
import 'package:paybook_app/routes/app_pages.dart';
import 'package:paybook_app/services/charge_service.dart';
import 'package:paybook_app/services/enum_book_type.dart';
import 'package:paybook_app/services/enum_charge_type.dart';

import 'charge_111_form_controller.dart';

class Charge111FormBinding implements Bindings {
  @override
  void dependencies() {
    var bookId = Preconditions.checkNotNull(
        Get.parameters[AppRoutes.Books.parameterBookId], 'bookId must no be null');

    UserController userController = Get.find<UserController>();
    assert(userController.user != null);

    var chargesCollection = ChargesCollection(userId: userController.user!.id, bookId: bookId);
    var cobrancaService =
        ChargeService(chargesCollection: chargesCollection, serializer: Charge111Model.serializer);

    var chargeModel;
    var chargeId = Get.parameters[AppRoutes.Charges.parameterChargeId];
    if (chargeId != null) {
      chargeModel = Get.arguments;
    }

    Get.put(Charge111FormController(
        cobrancaService: cobrancaService, bookID: bookId, chargeToEdit: chargeModel));
  }
}
