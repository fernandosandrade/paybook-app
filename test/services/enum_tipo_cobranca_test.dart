import 'package:flutter_test/flutter_test.dart';
import 'package:paybook_app/services/enum_tipo_cobranca.dart';

void main() {
  test('enum from codigo cobranca', () {
    var valueOfFromCodigo = EnumTipoCobranca.valueOfFromCodigo("111");
    expect(valueOfFromCodigo, EnumTipoCobranca.C_111);
  });
  test('get codCobranca', () {
    expect("111", EnumTipoCobranca.C_111.codCobranca);
  });
}
