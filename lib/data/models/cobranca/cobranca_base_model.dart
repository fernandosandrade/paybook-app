import 'package:built_value/built_value.dart';
import 'package:paybook_app/data/models/destinatario.dart';
import 'package:paybook_app/data/repository/document_repository_model.dart';

part 'cobranca_base_model.g.dart';

@BuiltValue(instantiable: false)
abstract class CobrancaBaseModel implements DocumentRepositoryModel {
  @BuiltValueField(wireName: "id_book")
  String get idBook;

  @BuiltValueField(wireName: "data_criacao")
  DateTime get dtCriacao;

  @BuiltValueField(wireName: "data_vencimento")
  DateTime get dtVencimento;

  double get valor;

  Destinatario get destinatario;

  String get status;

  CobrancaBaseModel rebuild(void Function(CobrancaBaseModelBuilder) updates);
  CobrancaBaseModelBuilder toBuilder();
}
