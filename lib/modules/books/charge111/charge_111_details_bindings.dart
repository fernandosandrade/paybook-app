import 'package:get/get.dart';
import 'package:paybook_app/data/collections/charges_collection.dart';
import 'package:paybook_app/data/collections/payment_links_collection.dart';
import 'package:paybook_app/data/models/charge/charge_111_model.dart';
import 'package:paybook_app/data/models/payment_link_model.dart';
import 'package:paybook_app/globals/preconditions.dart';
import 'package:paybook_app/modules/books/charge111/charge_111_details_controller.dart';
import 'package:paybook_app/modules/usuario/user_controller.dart';
import 'package:paybook_app/routes/app_pages.dart';
import 'package:paybook_app/services/charge_service.dart';
import 'package:paybook_app/services/enum_book_type.dart';
import 'package:paybook_app/services/enum_charge_type.dart';
import 'package:paybook_app/services/payment_link_service.dart';

import 'charge_111_form_controller.dart';

class Charge111DetailsBinding implements Bindings {
  @override
  void dependencies() {
    var bookId = Preconditions.checkNotNull(
        Get.parameters[AppRoutes.Books.parameterBookId], 'bookId must not be null');

    UserController userController = Get.find<UserController>();
    assert(userController.user != null);

    Charge111Model chargeModel = Get.arguments;

    var chargesCollection = ChargesCollection(userId: userController.user!.id, bookId: bookId);
    var paymentLinksCollection = PaymentLinksCollection(
        userId: userController.user!.id, bookId: bookId, chargeId: chargeModel.id);

    var chargeService =
        ChargeService(chargesCollection: chargesCollection, serializer: Charge111Model.serializer);
    var paymentLinkService = PaymentLinkService(
        paymentLinksCollection: paymentLinksCollection, serializer: PaymentLinkModel.serializer);

    Get.put(Charge111DetailsController(
        chargeService: chargeService,
        paymentLinkService: paymentLinkService,
        bookID: bookId,
        charge: chargeModel));
  }
}
