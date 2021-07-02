import 'package:get/get.dart';
import 'package:paybook_app/globals/preconditions.dart';
import 'package:paybook_app/modules/books/book_101_bindings.dart';
import 'package:paybook_app/modules/books/book_101_controller.dart';
import 'package:paybook_app/modules/books/book_101_page.dart';
import 'package:paybook_app/modules/books/book_201_controller.dart';
import 'package:paybook_app/modules/books/book_201_page.dart';
import 'package:paybook_app/modules/books/charge111/charge_111_form_bindings.dart';
import 'package:paybook_app/modules/books/charge111/charge_111_form_page.dart';
import 'package:paybook_app/modules/books/no_book_page.dart';
import 'package:paybook_app/modules/books/novo_book_page.dart';
import 'package:paybook_app/modules/destinatario/destinatario_bindings.dart';
import 'package:paybook_app/modules/destinatario/destinatario_page.dart';
import 'package:paybook_app/modules/home/home_bindings.dart';
import 'package:paybook_app/modules/login/login_bindings.dart';
import 'package:paybook_app/modules/login/login_page.dart';
import 'package:paybook_app/services/enum_tipo_book.dart';
import 'package:paybook_app/services/enum_tipo_cobranca.dart';

part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.HOME, page: () => NoBookPage(), binding: HomeBinding()),
    GetPage(name: AppRoutes.LOGIN, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(name: AppRoutes.NOVO_BOOK, page: () => NovoBookPage()),
    GetPage(
        name: AppRoutes.destinatario,
        page: () => DestinatarioPage(),
        binding: DestinatarioBinding()),

    // BOOKS PAGES
    GetPage(
        name: AppRoutes.Books.homeBook101URLTemplate,
        page: () => Book101Page(Preconditions.checkNotNull(
            Get.parameters[AppRoutes.Books.parameterBookId], 'nenhum book definido')),
        binding: Book101Bindings()),
    GetPage(
      name: AppRoutes.Books.homeBook201URLTemplate,
      page: () => Book201Page(Get.parameters[AppRoutes.Books.parameterBookId]),
    ),

    // GetPage(
    //     name: AppRoutes.CHARGE_111_FORM,
    //     page: () => BookSimplesFormPage(),
    //     bindings: [BookSimplesFormBinding(), BookBinding()]),

    // PAGINAS BOOK 101
    // GetPage(name: AppRoutes.SELETOR_COBRANCA_BOOK_101, page: () => SeletorCobrancaPage()),
    GetPage(
        name: AppRoutes.Charges.newCharge111FormURLTemplate,
        page: () => Charge111FormPage(),
        binding: Charge111FormBinding()),
    GetPage(
        name: AppRoutes.Charges.editCharge111FormURLTemplate,
        page: () => Charge111FormPage(),
        binding: Charge111FormBinding()),
  ];
}

// ignore: top_level_function_literal_block
