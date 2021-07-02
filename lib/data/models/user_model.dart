import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:paybook_app/data/repository/document_repository_model.dart';
import 'package:paybook_app/globals/serializers.dart';

part 'user_model.g.dart';

abstract class UserModel extends Object implements DocumentRepositoryModel, Built<UserModel, UserModelBuilder> {
  UserModel._();

  factory UserModel([void Function(UserModelBuilder) updates]) = _$UserModel;

  String get email;

  String get nome;

  String? get sobrenome;

  String? get telefone;

  String? get cep;

  static Serializer<UserModel> get serializer => _$userModelSerializer;

  Map<String, dynamic> toMap() {
    var serialized = serializers.serializeWith(UserModel.serializer, this) as Map<String, dynamic>;
    return Map<String, dynamic>.from(serialized);
  }
}
