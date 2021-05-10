import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:paybook_app/data/models/cobranca/cobranca_base_model.dart';
import 'package:paybook_app/globals/serializers.dart';
import 'package:paybook_app/data/models/destinatario.dart';

part 'cobranca_111_model.g.dart';

abstract class Cobranca111Model extends Object
    implements CobrancaBaseModel, Built<Cobranca111Model, Cobranca111ModelBuilder> {
  static Serializer<Cobranca111Model> get serializer => _$cobranca111ModelSerializer;

  Cobranca111Model._();
  factory Cobranca111Model([void Function(Cobranca111ModelBuilder) updates]) = _$Cobranca111Model;

  // fields

  Map<String, dynamic> toMap() {
    var serialized = serializers.serializeWith(Cobranca111Model.serializer, this) as Map<String, dynamic>;
    return Map<String, dynamic>.from(serialized);
  }
}
