import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:paybook_app/globals/serializers.dart';

part 'cobranca_211_model.g.dart';

abstract class Cobranca211Model implements Built<Cobranca211Model, Cobranca211ModelBuilder> {
  static Serializer<Cobranca211Model> get serializer => _$cobranca211ModelSerializer;

  Cobranca211Model._();
  factory Cobranca211Model([void Function(Cobranca211ModelBuilder) updates]) = _$Cobranca211Model;

  // fields

  String toJson() {
    return json.encode(serializers.serializeWith(Cobranca211Model.serializer, this));
  }

  static Cobranca211Model? fromJson(String jsonString) {
    return serializers.deserializeWith(Cobranca211Model.serializer, json.decode(jsonString));
  }
}
