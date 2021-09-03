import 'package:logging/logging.dart';
import 'package:paybook_app/http/charge_dto.dart';
import 'package:paybook_app/http/http_client.dart';
import 'package:paybook_app/http/server_uri_builder.dart';
import 'package:paybook_app/services/enum_charge_type.dart';

abstract class HttpService {
  static const _Charges Charges = _Charges();
}

class _Charges {
  const _Charges();

  generateLinks(EnumChargeType chargeType, ChargeDto dto) {
    var uri = ServerUriBuilder.Charges.forLinksGeneration(
        chargeType: chargeType, userId: dto.userId, bookId: dto.bookID, chargeId: dto.chargeId);
    Logger('HttpService._Charges').info('generating links for charge[${dto.chargeId}] on $uri');
    HttpClient.post(uri, dto.toJson());
  }
}
