import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:paybook_app/globals/serializers.dart';

import 'enum_charge_type.dart';

part 'enum_book_type.g.dart';

class EnumBookType extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 101)
  static const EnumBookType B_101 = _$b101;

  @BuiltValueEnumConst(wireNumber: 201)
  static const EnumBookType B_201 = _$b201;

  const EnumBookType._(String name) : super(name);

  static Serializer<EnumBookType> get serializer => _$enumBookTypeSerializer;
  static BuiltSet<EnumBookType> get values => _$values;
  static EnumBookType valueOf(String name) => _$valueOf(name);

  String get wireNumber => serializers.toJson(EnumBookType.serializer, this);
}
