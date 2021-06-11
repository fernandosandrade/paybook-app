import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:paybook_app/globals/serializers.dart';

part 'enum_link_status.g.dart';

class EnumLinkStatus extends EnumClass {
  /// [5] link aguardando o pagamento
  @BuiltValueEnumConst(wireNumber: 5)
  static const EnumLinkStatus waiting_paiment = _$waiting_paiment;

  /// [10] link pago
  @BuiltValueEnumConst(wireNumber: 10)
  static const EnumLinkStatus link_paid = _$link_paid;

  /// [11] link marcado manualmente como pago pelo usuário
  @BuiltValueEnumConst(wireNumber: 11)
  static const EnumLinkStatus link_set_as_paid = _$link_set_as_paid;

  /// [20] link cancelado
  @BuiltValueEnumConst(wireNumber: 20)
  static const EnumLinkStatus link_cancelled = _$link_cancelled;

  /// [21] link cancelado pelo usuário
  @BuiltValueEnumConst(wireNumber: 21)
  static const EnumLinkStatus link_set_as_cancelled = _$link_set_as_cancelled;

  /// [90] link vencido
  @BuiltValueEnumConst(wireNumber: 90)
  static const EnumLinkStatus link_expired = _$link_expired;

  const EnumLinkStatus._(String name) : super(name);

  static Serializer<EnumLinkStatus> get serializer => _$enumLinkStatusSerializer;
  static BuiltSet<EnumLinkStatus> get values => _$values;
  static EnumLinkStatus valueOf(String name) => _$valueOf(name);

  String get wireNumber => serializers.toJson(EnumLinkStatus.serializer, this);
}
