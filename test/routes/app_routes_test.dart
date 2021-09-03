import 'package:flutter_test/flutter_test.dart';
import 'package:paybook_app/routes/app_pages.dart';
import 'package:paybook_app/services/enum_book_type.dart';
import 'package:paybook_app/services/enum_charge_type.dart';

void main() {
  test('dynamic route test', () {
    expect(AppRoutes.Books.homeBook101URLTemplate, '/home/book/101/:book_id');

    expect(
        AppRoutes.Books.homeBookURLBuild(
            tipoBook: EnumBookType.B_101, bookID: '50zjPKx82aiAgjxzTKbY'),
        '/home/book/101/50zjPKx82aiAgjxzTKbY');

    expect(AppRoutes.Charges.newCharge111FormURLTemplate, '/charge/101/:book_id/111/');

    expect(AppRoutes.Charges.editCharge111FormURLTemplate, '/charge/101/:book_id/111/:charge_id');

    expect(
        AppRoutes.Charges.chargeFormURLBuild(
            tipoBook: EnumBookType.B_101,
            tipoCobranca: EnumChargeType.C_111,
            bookId: '50zjPKx82aiAgjxzTKbY'),
        '/charge/101/50zjPKx82aiAgjxzTKbY/111/');

    expect(
        AppRoutes.Charges.chargeFormURLBuild(
            tipoBook: EnumBookType.B_101,
            tipoCobranca: EnumChargeType.C_111,
            bookId: '50zjPKx82aiAgjxzTKbY',
            chargeId: 'JE4RTA1UbozO4r6fIkMU'),
        '/charge/101/50zjPKx82aiAgjxzTKbY/111/JE4RTA1UbozO4r6fIkMU');

    expect(AppRoutes.Books.bookFormURLBuild(tipoBook: EnumBookType.B_101), '/book/101/');

    expect(
        AppRoutes.Books.bookFormURLBuild(
            tipoBook: EnumBookType.B_101, bookId: '50zjPKx82aiAgjxzTKbY'),
        '/book/101/50zjPKx82aiAgjxzTKbY');

    expect(AppRoutes.Books.editBook101FormURLTemplate, '/book/101/:book_id');

    expect(AppRoutes.Books.newBook101FormURLTemplate, '/book/101/');
  });
}
