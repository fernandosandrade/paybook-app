import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:paybook_app/data/models/cobranca/cobranca_base_model.dart';
import 'package:paybook_app/globals/serializers.dart';

part 'user_model.g.dart';

abstract class UserModel extends Object implements CobrancaBaseModel, Built<UserModel, UserModelBuilder> {
  static Serializer<UserModel> get serializer => _$userModelSerializer;

  UserModel._();
  factory UserModel([void Function(UserModelBuilder) updates]) = _$UserModel;

  @BuiltValueField(wireName: "id_usuario")
  String get idUsuario;
  String get email;
  String get nome;
  String get sobrenome;
  String get telefone;
  String get cep;

  Map<String, dynamic> toMap() {
    var serialized = serializers.serializeWith(UserModel.serializer, this) as Map<String, dynamic>;
    return Map<String, dynamic>.from(serialized);
  }
}
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:json_annotation/json_annotation.dart';
//
// import 'models_definition.dart';
//
// part 'user_model.g.dart';
//
// @JsonSerializable()
// class UserModel extends IUserModel {
//   @JsonKey(name: 'id_usuario')
//   String idUsuario;
//   String email;
//   String nome;
//   String sobrenome;
//   String telefone;
//   String cep;
//
//   @JsonKey(name: 'data_cadastramento')
//   int dataCadastramento;
//
//   @JsonKey(ignore: true)
//   DocumentReference reference;
//
//   UserModel({required this.idUsuario, required this.email, required this.nome});
//
//   factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
//
//   UserModel fromJson(Map<String, dynamic> json) {
//     return UserModel.fromJson(json);
//   }
//
//   Map<String, dynamic> toJson() => _$UserModelToJson(this);
// }
