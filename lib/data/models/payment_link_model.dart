import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:paybook_app/data/models/payment_link_preview_model.dart';
import 'package:paybook_app/data/repository/document_repository_model.dart';
import 'package:paybook_app/globals/serializers.dart';
import 'package:paybook_app/services/enum_link_status.dart';

part 'payment_link_model.g.dart';

abstract class PaymentLinkModel extends Object
    implements DocumentRepositoryModel, Built<PaymentLinkModel, PaymentLinkModelBuilder> {
  PaymentLinkModel._();
  factory PaymentLinkModel([void Function(PaymentLinkModelBuilder) updates]) = _$PaymentLinkModel;

  @BuiltValueField(wireName: "id_cobranca")
  String get idCobranca;

  String get descricao;

  String get url;

  @BuiltValueField(wireName: "valor_principal")
  double get valorPrincipal;

  @BuiltValueField(wireName: "valor_taxas")
  double get valorTaxas;

  EnumLinkStatus get status;

  DateTime get vencimento;

  static Serializer<PaymentLinkModel> get serializer => _$paymentLinkModelSerializer;

  Map<String, dynamic> toMap() {
    var serialized = serializers.serializeWith(PaymentLinkModel.serializer, this) as Map<String, dynamic>;
    return Map<String, dynamic>.from(serialized);
  }
}
