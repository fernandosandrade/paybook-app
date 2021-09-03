import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:paybook_app/globals/serializers.dart';
import 'package:paybook_app/services/enum_link_status.dart';

part 'payment_link_preview_model.g.dart';

abstract class PaymentLinkPreviewModel
    implements Built<PaymentLinkPreviewModel, PaymentLinkPreviewModelBuilder> {
  PaymentLinkPreviewModel._();
  factory PaymentLinkPreviewModel([void Function(PaymentLinkPreviewModelBuilder) updates]) =
      _$PaymentLinkPreviewModel;

  String get id;

  EnumLinkStatus get status;

  int get valor;

  DateTime get vencimento;

  static Serializer<PaymentLinkPreviewModel> get serializer => _$paymentLinkPreviewModelSerializer;

  Map<String, dynamic> toMap() {
    var serialized =
        serializers.serializeWith(PaymentLinkPreviewModel.serializer, this) as Map<String, dynamic>;
    return Map<String, dynamic>.from(serialized);
  }
}
