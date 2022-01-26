import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:paybook_app/globals/serializers.dart';

part 'enum_charge_status.g.dart';

class EnumChargeStatus extends EnumClass {
  /// [0] charge active and open
  @BuiltValueEnumConst(wireNumber: 0)
  static const EnumChargeStatus charge_open = _$charge_open;

  /// [5] open charge waiting for some payment
  @BuiltValueEnumConst(wireNumber: 5)
  static const EnumChargeStatus waiting_payment = _$waiting_payment;

  /// [10] charge completed
  @BuiltValueEnumConst(wireNumber: 10)
  static const EnumChargeStatus charge_paid = _$charge_paid;

  /// [20] charge canceled
  @BuiltValueEnumConst(wireNumber: 20)
  static const EnumChargeStatus charge_canceled = _$charge_canceled;

  const EnumChargeStatus._(String name) : super(name);

  static Serializer<EnumChargeStatus> get serializer => _$enumChargeStatusSerializer;
  static BuiltSet<EnumChargeStatus> get values => _$values;
  static EnumChargeStatus valueOf(String name) => _$valueOf(name);

  String get wireNumber => serializers.toJson(EnumChargeStatus.serializer, this);
}
