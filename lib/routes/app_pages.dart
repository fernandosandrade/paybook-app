import 'package:get/get.dart';
import 'package:paybook_app/globals/preconditions.dart';
import 'package:paybook_app/modules/books/book101/book_101_form_bindings.dart';
import 'package:paybook_app/modules/books/book101/book_101_form_page.dart';
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
import 'package:paybook_app/services/enum_book_type.dart';
import 'package:paybook_app/services/enum_charge_type.dart';

part './app_routes.dart';

abstract class AppPages {
  static final pages = generalPages + book101pages;

  static final generalPages = [
    GetPage(name: AppRoutes.HOME, page: () => NoBookPage(), binding: HomeBinding()),
    GetPage(name: AppRoutes.LOGIN, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(name: AppRoutes.NOVO_BOOK, page: () => NovoBookPage()),
    GetPage(
        name: AppRoutes.destinatario,
        page: () => DestinatarioPage(),
        binding: DestinatarioBinding()),
  ];

  // all pages involving book 101 and its charges
  static final book101pages = [
    GetPage(
        name: AppRoutes.Books.homeBook101URLTemplate,
        page: () => Book101Page(Preconditions.checkNotNull(
            Get.parameters[AppRoutes.Books.parameterBookId], 'nenhum book definido')),
        binding: Book101Bindings()),
    GetPage(
        name: AppRoutes.Books.newBook101FormURLTemplate,
        page: () => Book101FormPage(),
        binding: Book101FormBinding()),
    GetPage(
        name: AppRoutes.Books.editBook101FormURLTemplate,
        page: () => Book101FormPage(),
        binding: Book101FormBinding()),
    GetPage(
        name: AppRoutes.Charges.newCharge111FormURLTemplate,
        page: () => Charge111FormPage(),
        binding: Charge111FormBinding()),
    GetPage(
        name: AppRoutes.Charges.editCharge111FormURLTemplate,
        page: () => Charge111FormPage(),
        binding: Charge111FormBinding()),
  ];

  // all pages involving book 201 and its charges
  static final book201pages = [
    GetPage(
      name: AppRoutes.Books.homeBook201URLTemplate,
      page: () => Book201Page(Get.parameters[AppRoutes.Books.parameterBookId]),
    ),
  ];
}
