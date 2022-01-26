// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UserModel> _$userModelSerializer = new _$UserModelSerializer();

class _$UserModelSerializer implements StructuredSerializer<UserModel> {
  @override
  final Iterable<Type> types = const [UserModel, _$UserModel];
  @override
  final String wireName = 'UserModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, UserModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'nome',
      serializers.serialize(object.nome, specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.sobrenome;
    if (value != null) {
      result
        ..add('sobrenome')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.telefone;
    if (value != null) {
      result
        ..add('telefone')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.cep;
    if (value != null) {
      result
        ..add('cep')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  UserModel deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'nome':
          result.nome = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'sobrenome':
          result.sobrenome = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'telefone':
          result.telefone = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'cep':
          result.cep = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$UserModel extends UserModel {
  @override
  final String email;
  @override
  final String nome;
  @override
  final String? sobrenome;
  @override
  final String? telefone;
  @override
  final String? cep;
  @override
  final String id;

  factory _$UserModel([void Function(UserModelBuilder)? updates]) =>
      (new UserModelBuilder()..update(updates)).build();

  _$UserModel._(
      {required this.email,
      required this.nome,
      this.sobrenome,
      this.telefone,
      this.cep,
      required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(email, 'UserModel', 'email');
    BuiltValueNullFieldError.checkNotNull(nome, 'UserModel', 'nome');
    BuiltValueNullFieldError.checkNotNull(id, 'UserModel', 'id');
  }

  @override
  UserModel rebuild(void Function(UserModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserModelBuilder toBuilder() => new UserModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserModel &&
        email == other.email &&
        nome == other.nome &&
        sobrenome == other.sobrenome &&
        telefone == other.telefone &&
        cep == other.cep &&
        id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, email.hashCode), nome.hashCode),
                    sobrenome.hashCode),
                telefone.hashCode),
            cep.hashCode),
        id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserModel')
          ..add('email', email)
          ..add('nome', nome)
          ..add('sobrenome', sobrenome)
          ..add('telefone', telefone)
          ..add('cep', cep)
          ..add('id', id))
        .toString();
  }
}

class UserModelBuilder
    implements
        Builder<UserModel, UserModelBuilder>,
        DocumentRepositoryModelBuilder {
  _$UserModel? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(covariant String? email) => _$this._email = email;

  String? _nome;
  String? get nome => _$this._nome;
  set nome(covariant String? nome) => _$this._nome = nome;

  String? _sobrenome;
  String? get sobrenome => _$this._sobrenome;
  set sobrenome(covariant String? sobrenome) => _$this._sobrenome = sobrenome;

  String? _telefone;
  String? get telefone => _$this._telefone;
  set telefone(covariant String? telefone) => _$this._telefone = telefone;

  String? _cep;
  String? get cep => _$this._cep;
  set cep(covariant String? cep) => _$this._cep = cep;

  String? _id;
  String? get id => _$this._id;
  set id(covariant String? id) => _$this._id = id;

  UserModelBuilder();

  UserModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _nome = $v.nome;
      _sobrenome = $v.sobrenome;
      _telefone = $v.telefone;
      _cep = $v.cep;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant UserModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserModel;
  }

  @override
  void update(void Function(UserModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserModel build() {
    final _$result = _$v ??
        new _$UserModel._(
            email: BuiltValueNullFieldError.checkNotNull(
                email, 'UserModel', 'email'),
            nome: BuiltValueNullFieldError.checkNotNull(
                nome, 'UserModel', 'nome'),
            sobrenome: sobrenome,
            telefone: telefone,
            cep: cep,
            id: BuiltValueNullFieldError.checkNotNull(id, 'UserModel', 'id'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
