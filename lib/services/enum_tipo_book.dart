import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'enum_tipo_book.g.dart';

class EnumTipoBook extends EnumClass {
  static Serializer<EnumTipoBook> get serializer => _$enumTipoBookSerializer;

  static const EnumTipoBook B_101 = _$b101;
  static const EnumTipoBook B_201 = _$b201;

  const EnumTipoBook._(String name) : super(name);

  static BuiltSet<EnumTipoBook> get values => _$values;
  static EnumTipoBook valueOf(String name) => _$valueOf(name);

  static EnumTipoBook valueOfFromCodigo(String name) => _$valueOf("B_" + name);
  String get codBook => this.name.substring(2);
}
