part of './app_pages.dart';

abstract class AppRoutes {
  static const INITIAL = '/';
  static const HOME = '/home';
  static const LOGIN = '/login';

  /// pagina que permite selecionar o tipo de book a ser criado
  static const NOVO_BOOK = '/novo_book';

  /// pagina para criacao de um novo book simples
  static const BOOK_SIMPLES_FORM = '/book_simples_form';

  /// pagina que mostra o conteudo do book
  static const BOOK_SIMPLES_LIST = '/book_simples_list';

  /// form para criacao de uma nova cobranca simples
  static const COBRANCA_SIMPLES_FORM = '/cobranca_simples';

  /// form para criacao de uma nova cobranca simples
  static const SELETOR_COBRANCA_BOOK_101 = '/seletor_cobranca_book101';

  /// pagina para edicao do destinatario da cobranca
  static const DESTINATARIO = '/destinatario';
}
