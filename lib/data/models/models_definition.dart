import 'destinatario.dart';

/// arquivo concentra todas as definicoes de Models para banco de dados.
/// desta forma, é mais facil identificar os atributos comuns entre os modelos, como chaves estrangeiras, etc
///
/// cada model deve representar precisamente uma colecao da base de dados

/// model Usuario
abstract class IUserModel {
  String get idUsuario;
  String get email;
  String get nome;
  String get sobrenome;
  String get telefone;
  String get cep;
  int get dataCadastramento;
}

/// definicao do model CobrancaSimples
abstract class ICobranca101Model {
  String get idCobranca;
  String get idBook;
  DateTime get dtCriacao;
  DateTime get dtVencimento;
  double get valor;
  Destinatario get destinatario;
  String get status;
}

abstract class IDestinatario {
  String get nome;
  String get telefone;
  String get email;
}

/// definicao do book de cobranca basico
abstract class IBookStoreModel {
  String get idBook;
  String get idUsuario;
  String get tipoBook;
  String get nomeBook;
  //Map<String, dynamic> get atributos;
}
