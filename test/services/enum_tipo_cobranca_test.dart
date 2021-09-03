import 'package:flutter_test/flutter_test.dart';
import 'package:paybook_app/globals/serializers.dart';
import 'package:paybook_app/services/enum_charge_type.dart';

void main() {
  test('enum from codigo cobranca', () {
    String wireNumber = EnumChargeType.C_112.wireNumber;
    var valueOfFromCodigo = EnumChargeType.valueOf("C_111");
    expect(valueOfFromCodigo, EnumChargeType.C_111);
  });
  test('get codCobranca', () {
    expect("111", EnumChargeType.C_111);
  });
  test('serialize codCobranca', () {
    print(serializers.toJson(EnumChargeType.serializer, EnumChargeType.C_111));
    expect("111", EnumChargeType.C_111);
  });
}
