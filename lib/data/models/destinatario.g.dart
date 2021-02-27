// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'destinatario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Destinatario _$DestinatarioFromJson(Map<String, dynamic> json) {
  return Destinatario(
    nome: json['nome'] as String,
    email: json['email'] as String,
    telefone: json['telefone'] as String,
  );
}

Map<String, dynamic> _$DestinatarioToJson(Destinatario instance) =>
    <String, dynamic>{
      'nome': instance.nome,
      'email': instance.email,
      'telefone': instance.telefone,
    };
