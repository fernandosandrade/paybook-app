import 'package:get/get.dart';

import '../modules/books/book_101/seletor_cobranca_page.dart';
import '../modules/books/book_101/book_simples_form_bindings.dart';
import '../modules/books/book_101/book_simples_form_page.dart';
import '../modules/books/book_101/cobranca_111/cobranca_simples_form_bindings.dart';
import '../modules/books/book_101/cobranca_111/cobranca_simples_form_page.dart';
import '../modules/books/book_bindings.dart';
import '../modules/books/novo_book_page.dart';
import '../modules/destinatario/destinatario_bindings.dart';
import '../modules/destinatario/destinatario_page.dart';
import '../modules/home/home_bindings.dart';
import '../modules/home/home_page.dart';
import '../modules/login/login_bindings.dart';
import '../modules/login/login_page.dart';

part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.HOME, page: () => HomePage(), binding: HomeBinding()),
    GetPage(name: AppRoutes.LOGIN, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(name: AppRoutes.NOVO_BOOK, page: () => NovoBookPage(), binding: BookBinding()),
    GetPage(
        name: AppRoutes.BOOK_SIMPLES_FORM,
        page: () => BookSimplesFormPage(),
        bindings: [BookSimplesFormBinding(), BookBinding()]),

    // PAGINAS BOOK 101
    GetPage(name: AppRoutes.SELETOR_COBRANCA_BOOK_101, page: () => SeletorCobrancaPage()),
    GetPage(
        name: AppRoutes.COBRANCA_SIMPLES_FORM,
        page: () => CobrancaSimplesFormPage(),
        binding: CobrancaSimplesFormBinding()),
    GetPage(
        name: AppRoutes.DESTINATARIO,
        page: () => DestinatarioPage(),
        binding: DestinatarioBinding()),
  ];
}
