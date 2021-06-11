import 'package:flutter_test/flutter_test.dart';
import 'package:paybook_app/globals/serializers.dart';
import 'package:paybook_app/services/enum_tipo_cobranca.dart';

void main() {
  test('enum from codigo cobranca', () {
    String wireNumber = EnumTipoCobranca.C_112.wireNumber;
    var valueOfFromCodigo = EnumTipoCobranca.valueOf("C_111");
    expect(valueOfFromCodigo, EnumTipoCobranca.C_111);
  });
  test('get codCobranca', () {
    expect("111", EnumTipoCobranca.C_111);
  });
  test('serialize codCobranca', () {
    print(serializers.toJson(EnumTipoCobranca.serializer, EnumTipoCobranca.C_111));
    expect("111", EnumTipoCobranca.C_111);
  });
}
