import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:memoize/memoize.dart';
import 'package:paybook_app/globals/serializers.dart';

part 'enum_tipo_cobranca.g.dart';

class EnumTipoCobranca extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 111)
  static const EnumTipoCobranca C_111 = _$c111;

  @BuiltValueEnumConst(wireNumber: 112)
  static const EnumTipoCobranca C_112 = _$c112;

  const EnumTipoCobranca._(String name) : super(name);

  static Serializer<EnumTipoCobranca> get serializer => _$enumTipoCobrancaSerializer;
  static BuiltSet<EnumTipoCobranca> get values => _$values;
  static EnumTipoCobranca valueOf(String name) => _$valueOf(name);
  String get wireNumber => serializers.toJson(EnumTipoCobranca.serializer, this);
}
