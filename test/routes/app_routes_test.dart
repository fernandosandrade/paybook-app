import 'package:flutter_test/flutter_test.dart';
import 'package:paybook_app/routes/app_pages.dart';
import 'package:paybook_app/services/enum_tipo_book.dart';

void main() {
  test('dynamic route test', () {
    print(AppRoutes.book_101_home);
    print(AppRoutes.homeBookBuild(tipoBook: EnumTipoBook.B_101, bookID: '123456'));
  });
}
