import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:paybook_app/globals/serializers.dart';

import 'enum_tipo_cobranca.dart';

part 'enum_tipo_book.g.dart';

class EnumTipoBook extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 101)
  static const EnumTipoBook B_101 = _$b101;

  @BuiltValueEnumConst(wireNumber: 201)
  static const EnumTipoBook B_201 = _$b201;

  const EnumTipoBook._(String name) : super(name);

  static Serializer<EnumTipoBook> get serializer => _$enumTipoBookSerializer;
  static BuiltSet<EnumTipoBook> get values => _$values;
  static EnumTipoBook valueOf(String name) => _$valueOf(name);

  String get wireNumber => serializers.toJson(EnumTipoBook.serializer, this);
}
