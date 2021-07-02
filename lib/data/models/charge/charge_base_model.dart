import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:paybook_app/data/repository/document_repository_model.dart';
import 'package:paybook_app/services/enum_cobranca_status.dart';

import '../destinatario.dart';
import '../payment_link_preview_model.dart';

part 'charge_base_model.g.dart';

@BuiltValue(instantiable: false)
abstract class ChargeBaseModel implements DocumentRepositoryModel {
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

  ChargeBaseModel rebuild(void Function(ChargeBaseModelBuilder) updates);
  ChargeBaseModelBuilder toBuilder();
}
