import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:paybook_app/data/repository/document_repository_model.dart';
import 'package:paybook_app/services/enum_cobranca_status.dart';
import 'package:paybook_app/services/enum_charge_type.dart';

import '../destinatario.dart';
import '../payment_link_preview_model.dart';

part 'abstract_charge_base_model.g.dart';

@BuiltValue(instantiable: false)
abstract class AbstractChargeBaseModel implements DocumentRepositoryModel {
  @BuiltValueField(wireName: "charge_type")
  EnumChargeType get chargeType;

  @BuiltValueField(wireName: "creation_date")
  DateTime get creationDate;

  int get amount;

  Destinatario get receiver;

  EnumCobrancaStatus get status;

  @BuiltValueField(wireName: "payment_links")
  BuiltList<PaymentLinkPreviewModel> get paymentLinks;

  AbstractChargeBaseModel rebuild(void Function(AbstractChargeBaseModelBuilder) updates);
  AbstractChargeBaseModelBuilder toBuilder();
}
