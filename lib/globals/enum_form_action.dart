// enum EnumFormAction { INCLUIR, ALTERAR, INDEFINIDA }
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'enum_form_action.g.dart';

class EnumFormAction extends EnumClass {
  static Serializer<EnumFormAction> get serializer => _$enumFormActionSerializer;

  static const EnumFormAction INCLUIR = _$INCLUIR;
  static const EnumFormAction ALTERAR = _$ALTERAR;
  static const EnumFormAction INDEFINIDA = _$INDEFINIDA;

  const EnumFormAction._(String name) : super(name);

  static BuiltSet<EnumFormAction> get values => _$values;
  static EnumFormAction valueOf(String name) => _$valueOf(name);
}
