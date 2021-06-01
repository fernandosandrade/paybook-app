part of './app_pages.dart';

abstract class AppRoutes {
  static const String parameter_book_id = 'book_id';

  static const INITIAL = '/';
  static const HOME = '/home';
  static const LOGIN = '/login';

  /// builds a route to open the informed book on home screen
  static String homeBookBuild({required EnumTipoBook tipoBook, required String bookID}) {
    return '/home/book/${tipoBook.codBook}/$bookID';
  }

  static const book_101_home = '/home/book/101/:$parameter_book_id';

  static const book_201_home = '/home/book/201/:$parameter_book_id';

  /// pagina que permite selecionar o tipo de book a ser criado
  static const NOVO_BOOK = '/novo_book';

  /// pagina para criacao de um novo book simples
  static const BOOK_SIMPLES_FORM = '/book_simples_form';

  /// pagina que mostra o conteudo do book
  // static const BOOK_SIMPLES_LIST = '/book_simples_list';

  /// form para criacao de uma nova cobranca simples
  static const COBRANCA_SIMPLES_FORM = '/cobranca_simples';

  /// form para criacao de uma nova cobranca simples
  static const SELETOR_COBRANCA_BOOK_101 = '/seletor_cobranca_book101';

  /// pagina para edicao do destinatario da cobranca
  static const DESTINATARIO = '/destinatario';
}

abstract class DynamicRouteBuilder {}
