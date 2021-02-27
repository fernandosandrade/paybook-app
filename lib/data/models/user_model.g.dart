// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    idUsuario: json['id_usuario'] as String,
    email: json['email'] as String,
    nome: json['nome'] as String,
  )
    ..sobrenome = json['sobrenome'] as String
    ..telefone = json['telefone'] as String
    ..cep = json['cep'] as String
    ..dataCadastramento = json['data_cadastramento'] as int;
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id_usuario': instance.idUsuario,
      'email': instance.email,
      'nome': instance.nome,
      'sobrenome': instance.sobrenome,
      'telefone': instance.telefone,
      'cep': instance.cep,
      'data_cadastramento': instance.dataCadastramento,
    };
