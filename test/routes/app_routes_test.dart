import 'package:flutter_test/flutter_test.dart';
import 'package:paybook_app/routes/app_pages.dart';
import 'package:paybook_app/services/enum_tipo_book.dart';
import 'package:paybook_app/services/enum_tipo_cobranca.dart';

void main() {
  test('dynamic route test', () {
    print(AppRoutes.Books.homeBook101URLTemplate);
    print(AppRoutes.Books.homeBookURLBuild(tipoBook: EnumTipoBook.B_101, bookID: '123456'));
    print(AppRoutes.Charges.newCharge111FormURLTemplate);
    print(AppRoutes.Charges.chargeFormURLBuild(
        tipoBook: EnumTipoBook.B_101, tipoCobranca: EnumTipoCobranca.C_111, bookId: '4152'));
    print(AppRoutes.Charges.chargeFormURLBuild(
        tipoBook: EnumTipoBook.B_101,
        tipoCobranca: EnumTipoCobranca.C_111,
        bookId: '4152',
        chargeId: ''
            '5478e5e4'
            ''));
  });
}
