import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:paybook_app/globals/serializers.dart';

part 'enum_charge_type.g.dart';

class EnumChargeType extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 111)
  static const EnumChargeType C_111 = _$c111;

  @BuiltValueEnumConst(wireNumber: 112)
  static const EnumChargeType C_112 = _$c112;

  const EnumChargeType._(String name) : super(name);

  static Serializer<EnumChargeType> get serializer => _$enumChargeTypeSerializer;
  static BuiltSet<EnumChargeType> get values => _$values;
  static EnumChargeType valueOf(String name) => _$valueOf(name);
  String get wireNumber => serializers.toJson(EnumChargeType.serializer, this);
}
