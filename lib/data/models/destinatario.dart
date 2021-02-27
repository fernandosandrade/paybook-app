import 'package:json_annotation/json_annotation.dart';

import 'models_definition.dart';

part 'destinatario.g.dart';

@JsonSerializable()
class Destinatario extends IDestinatario {
  String nome;
  String email;
  String telefone;

  Destinatario({this.nome, this.email, this.telefone});

  factory Destinatario.fromJson(Map<String, dynamic> json) => _$DestinatarioFromJson(json);

  Destinatario fromJson(Map<String, dynamic> json) {
    return Destinatario.fromJson(json);
  }

  Map<String, dynamic> toJson() => _$DestinatarioToJson(this);
}
