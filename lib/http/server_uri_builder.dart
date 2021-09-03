import 'package:paybook_app/services/enum_charge_type.dart';
import 'package:sprintf/sprintf.dart';

abstract class ServerUriBuilder {
  static const String baseUri = 'http://10.0.2.2:8080/v1';

  static const _Charges Charges = _Charges();
}

class _Charges {
  const _Charges();

  static const String chargesUri = 'charges';

  static const String s = '/users/%s/books/%s/charges/%s/%s/paylinks';

  /// builds uri for generate links to passed charge
  /// return example:
  /// ```
  /// http://10.0.2.2:8080/v1/charges/111/paylinks
  /// ```
  Uri forLinksGeneration(
      {required EnumChargeType chargeType,
      required String userId,
      required String bookId,
      required String chargeId}) {
    return Uri.parse('${ServerUriBuilder.baseUri}${sprintf(s, [
          userId,
          bookId,
          chargeType.wireNumber,
          chargeId
        ])}');
    // return Uri.parse('${ServerUriBuilder.baseUri}/$chargesUri/${chargeType.wireNumber}/paylinks');
  }
}
