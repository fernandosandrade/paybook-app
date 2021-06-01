import 'package:get/get.dart';
import 'package:paybook_app/modules/books/book_101_controller.dart';
import 'package:paybook_app/modules/books/book_201_controller.dart';
import 'package:paybook_app/modules/books/book_201_page.dart';
import 'package:paybook_app/modules/books/novo_book_page.dart';
import 'package:paybook_app/modules/destinatario/destinatario_bindings.dart';
import 'package:paybook_app/modules/destinatario/destinatario_page.dart';
import 'package:paybook_app/modules/home/home_bindings.dart';
import 'package:paybook_app/modules/home/home_page.dart';
import 'package:paybook_app/modules/login/login_bindings.dart';
import 'package:paybook_app/modules/login/login_page.dart';
import 'package:paybook_app/services/enum_tipo_book.dart';

part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.HOME, page: () => Book201Page(), binding: HomeBinding()),
    GetPage(name: AppRoutes.LOGIN, page: () => LoginPage(), binding: LoginBinding()),
    // GetPage(name: AppRoutes.NOVO_BOOK, page: () => NovoBookPage(), binding: BookBinding()),
    GetPage(name: AppRoutes.NOVO_BOOK, page: () => NovoBookPage()),
    GetPage(name: AppRoutes.DESTINATARIO, page: () => DestinatarioPage(), binding: DestinatarioBinding()),
    GetPage(
        name: AppRoutes.book_101_home,
        page: () => Book201Page(),
        binding: BindingsBuilder(() => Get.put(Book101Controller()))),

    GetPage(
        name: AppRoutes.book_201_home,
        page: () => Book201Page(),
        binding: BindingsBuilder(() => Get.put(Book201Controller()))),

    // GetPage(
    //     name: AppRoutes.BOOK_SIMPLES_FORM,
    //     page: () => BookSimplesFormPage(),
    //     bindings: [BookSimplesFormBinding(), BookBinding()]),

    // PAGINAS BOOK 101
    // GetPage(name: AppRoutes.SELETOR_COBRANCA_BOOK_101, page: () => SeletorCobrancaPage()),
    // GetPage(
    //     name: AppRoutes.COBRANCA_SIMPLES_FORM,
    //     page: () => CobrancaSimplesFormPage(),
    //     binding: CobrancaSimplesFormBinding()),
  ];
}
