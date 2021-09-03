import 'dart:convert';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:paybook_app/globals/serializers.dart';

part 'destinatario.g.dart';

abstract class Destinatario extends Object implements Built<Destinatario, DestinatarioBuilder> {
  static Serializer<Destinatario> get serializer => _$destinatarioSerializer;

  Destinatario._();
  factory Destinatario([void Function(DestinatarioBuilder) updates]) = _$Destinatario;

  String get nome;
  String get email;
  String get telefone;

  Map<String, dynamic> toMap() {
    var serialized =
        serializers.serializeWith(Destinatario.serializer, this) as Map<String, dynamic>;
    return Map<String, dynamic>.from(serialized);
  }

  // String toJson() {
  //   return json.encode(serializers.serializeWith(Destinatario.serializer, this));
  // }
  //
  // static Destinatario? fromJson(String jsonString) {
  //   return serializers.deserializeWith(Destinatario.serializer, json.decode(jsonString));
  // }
}
