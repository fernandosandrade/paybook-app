import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:paybook_app/data/models/destinatario.dart';
import 'package:paybook_app/data/repository/document_repository_model.dart';
import 'package:paybook_app/services/enum_cobranca_status.dart';

import '../payment_link_preview_model.dart';

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

  EnumCobrancaStatus get status;

  @BuiltValueField(wireName: "links_pagamento")
  BuiltList<PaymentLinkPreviewModel> get linksPagamento;

  CobrancaBaseModel rebuild(void Function(CobrancaBaseModelBuilder) updates);
  CobrancaBaseModelBuilder toBuilder();
}
