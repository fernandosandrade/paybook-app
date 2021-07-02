import 'package:get/get.dart';
import 'package:paybook_app/data/models/charge/charge_111_model.dart';
import 'package:paybook_app/globals/preconditions.dart';
import 'package:paybook_app/routes/app_pages.dart';
import 'package:paybook_app/services/cobranca_service.dart';
import 'package:paybook_app/services/enum_tipo_book.dart';
import 'package:paybook_app/services/enum_tipo_cobranca.dart';

import 'charge_111_form_controller.dart';

class Charge111FormBinding implements Bindings {
  @override
  void dependencies() {
    var bookId = Preconditions.checkNotNull(
        Get.parameters[AppRoutes.Books.parameterBookId], 'bookId must no be null');

    var chargeModel;
    var chargeId = Get.parameters[AppRoutes.Charges.parameterChargeId];
    if (chargeId != null) {
      chargeModel = Preconditions.checkNotNull<Charge111Model>(
          Get.arguments, 'must inform chargeModel as argument');
    }

    Get.put(Charge111FormController(
        cobrancaService: CobrancaService(
            book: EnumTipoBook.B_101,
            cobranca: EnumTipoCobranca.C_111,
            serializer: Charge111Model.serializer),
        bookID: bookId,
        chargeToEdit: chargeModel));
  }
}
