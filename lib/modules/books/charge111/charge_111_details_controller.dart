import 'package:get/get.dart';
import 'package:logging/logging.dart';
import 'package:paybook_app/data/models/charge/charge_111_model.dart';
import 'package:paybook_app/data/models/payment_link_model.dart';
import 'package:paybook_app/services/charge_service.dart';
import 'package:paybook_app/services/payment_link_service.dart';

class Charge111DetailsController extends GetxController {
  final log = Logger('Charge111DetailsController');

  final IChargeService<Charge111Model> chargeService;

  final IPaymentLinkService paymentLinkService;

  final Charge111Model charge;

  final String bookID;

  final paymentLinks = <PaymentLinkModel?>[].obs;

  Charge111DetailsController(
      {required this.chargeService,
      required this.paymentLinkService,
      required this.bookID,
      required this.charge}) {
    _doInit();
  }

  void _doInit() {
    this.paymentLinkService.listAll().then((value) {
      log.info('payment links for chargeId=${charge.id}: ${value.map((e) => e!.id).toList()}');
      this.paymentLinks.value = value;
    });
  }
}
