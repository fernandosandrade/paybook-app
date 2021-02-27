import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import 'models_definition.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends IUserModel {
  @JsonKey(name: 'id_usuario')
  String idUsuario;
  String email;
  String nome;
  String sobrenome;
  String telefone;
  String cep;

  @JsonKey(name: 'data_cadastramento')
  int dataCadastramento;

  @JsonKey(ignore: true)
  DocumentReference reference;

  UserModel({this.idUsuario, this.email, this.nome});

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  UserModel fromJson(Map<String, dynamic> json) {
    return UserModel.fromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
