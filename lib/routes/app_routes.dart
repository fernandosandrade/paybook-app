part of './app_pages.dart';

/// App routes
abstract class AppRoutes {
  /// URLs routes for books
  ///
  /// The default URL format for books are ``/home/book/101/{book_id}``
  static const _Books Books = _Books();

  /// URLs routes for charges
  ///
  /// /cobrancas/101/111/{charge_id}
  static const _Charges Charges = _Charges();

  /// URLs routes for payment link
  ///
  /// /cobrancas/101/111/{charge_id}/links_pagamento/{payment_link_id}
  static const _PaymentLinks PaymentLinks = _PaymentLinks();

  /// basics
  static const INITIAL = '/';
  static const HOME = '/home';
  static const LOGIN = '/login';

  /// pagina para edicao do destinatario da cobranca
  static const destinatario = '/destinatario';

  /// pagina que permite selecionar o tipo de book a ser criado
  static const NOVO_BOOK = '/novo_book';
}

/// Books routes
class _Books {
  const _Books();

  /// return const ``book_id``
  static const String _parameter_book_id = 'book_id';

  /// parameter name for book id on URL
  String get parameterBookId => _parameter_book_id;

  /// builds a route to open the informed book on home screen
  String homeBookURLBuild({required EnumBookType tipoBook, required String bookID}) {
    return '/home/book/${tipoBook.wireNumber}/$bookID';
  }

  /// URL template for book 101 to show on home screen
  final homeBook101URLTemplate = '/home/book/101/:$_parameter_book_id';

  /// URL template for book 201 to show on home screen
  final homeBook201URLTemplate = '/home/book/201/:$_parameter_book_id';

  /// Build URL route for create or edit a book.
  /// For edit, set ``bookId`` parameter. If available, pass the object model as ``Get.arguments``.
  ///
  /// example
  /// ```
  /// To edit book 5478e5e4:
  /// Get.to(AppRoutes.Books.bookFormURLBuild(
  ///         tipoBook: EnumTipoBook.B_101,
  ///         chargeId: '5478e5e4'));
  ///
  /// To create a new book:
  /// Get.to(AppRoutes.Books.bookFormURLBuild(tipoBook: EnumTipoBook.B_101));
  /// ```
  String bookFormURLBuild({required EnumBookType tipoBook, String bookId = ''}) {
    return '/books/${tipoBook.wireNumber}/$bookId';
  }

  /// route for new book 101: ``/books/101/``
  final newBook101FormURLTemplate = '/books/101/';

  /// route for edit book 101: ``/books/101/:book_id``
  final editBook101FormURLTemplate = '/books/101/:${_Books._parameter_book_id}';

  /// route for new book 201: ``/books/201/``
  final newBook201FormURLTemplate = '/books/201/';

  /// route for edit book 201: ``/books/201/:book_id``
  final editBook201FormURLTemplate = '/books/201/:${_Books._parameter_book_id}';
}

class _Charges {
  const _Charges();

  static const String _parameter_charge_id = 'charge_id';

  String get parameterChargeId => _parameter_charge_id;

  /// Build URL route for create or edit a charge.
  /// For edit, set ``chargeId`` parameter. If available, can pass the object model.
  ///
  /// example
  /// ```
  /// To edit charge 5478e5e4:
  /// Get.to(AppRoutes.Charges.chargeFormURLBuild(
  ///         tipoBook: EnumTipoBook.B_101,
  ///         tipoCobranca: EnumTipoCobranca.C_111,
  ///         chargeId: '5478e5e4'));
  ///
  /// To create new charge:
  /// Get.to(AppRoutes.Charges.chargeFormURLBuild(
  ///         tipoBook: EnumTipoBook.B_101,
  ///         tipoCobranca: EnumTipoCobranca.C_111));
  /// ```
  String chargeFormURLBuild(
      {required EnumBookType tipoBook,
      required EnumChargeType tipoCobranca,
      required String bookId,
      String chargeId = ''}) {
    return '/charges/${tipoBook.wireNumber}/$bookId/${tipoCobranca.wireNumber}/$chargeId';
  }

  /// route for new charge: ``/charges/101/:book_id/111/``
  final newCharge111FormURLTemplate = '/charges/101/:${_Books._parameter_book_id}/111/';

  /// route for edit charge: ``/charges/101/:book_id/111/:charge_id``
  final editCharge111FormURLTemplate =
      '/charges/101/:${_Books._parameter_book_id}/111/:${_Charges._parameter_charge_id}';
}

class _PaymentLinks {
  const _PaymentLinks();
}
