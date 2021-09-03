import 'package:flutter_test/flutter_test.dart';
import 'package:paybook_app/http/server_uri_builder.dart';
import 'package:paybook_app/services/enum_charge_type.dart';

void main() {
  test('uri charges builder', () {
    // /users/Mq9lYGNRx1GOCWKKXYnoz3MJNIBc/books/69Z77K13BR9W86J50014/charges/111/HFUhMb1YUJSKJPORFARE
    var user = 'Mq9lYGNRx1GOCWKKXYnoz3MJNIBc';
    var book = '69Z77K13BR9W86J50014';
    var charge = 'HFUhMb1YUJSKJPORFARE';
    var uri = ServerUriBuilder.Charges.forLinksGeneration(
        chargeType: EnumChargeType.C_111, userId: user, bookId: book, chargeId: charge);
    expect(
        uri.toString(),
        'http://10.0.2.2:8080/v1/users/Mq9lYGNRx1GOCWKKXYnoz3MJNIBc/books/69Z77K13BR9W86J50014'
        '/charges/111/HFUhMb1YUJSKJPORFARE/paylinks');
  });
}
