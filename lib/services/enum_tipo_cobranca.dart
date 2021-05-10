import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'enum_tipo_cobranca.g.dart';

class EnumTipoCobranca extends EnumClass {
  static Serializer<EnumTipoCobranca> get serializer => _$enumTipoCobrancaSerializer;

  static const EnumTipoCobranca C_111 = _$c111;
  static const EnumTipoCobranca C_112 = _$c112;

  const EnumTipoCobranca._(String name) : super(name);

  static BuiltSet<EnumTipoCobranca> get values => _$values;
  static EnumTipoCobranca valueOf(String name) => _$valueOf(name);

  static EnumTipoCobranca valueOfFromCodigo(String name) => _$valueOf("C_" + name);
  String get codCobranca => this.name.substring(2);
}
