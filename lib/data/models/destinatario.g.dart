// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'destinatario.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Destinatario> _$destinatarioSerializer =
    new _$DestinatarioSerializer();

class _$DestinatarioSerializer implements StructuredSerializer<Destinatario> {
  @override
  final Iterable<Type> types = const [Destinatario, _$Destinatario];
  @override
  final String wireName = 'Destinatario';

  @override
  Iterable<Object?> serialize(Serializers serializers, Destinatario object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'nome',
      serializers.serialize(object.nome, specifiedType: const FullType(String)),
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'telefone',
      serializers.serialize(object.telefone,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  Destinatario deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DestinatarioBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'nome':
          result.nome = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'telefone':
          result.telefone = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Destinatario extends Destinatario {
  @override
  final String nome;
  @override
  final String email;
  @override
  final String telefone;

  factory _$Destinatario([void Function(DestinatarioBuilder)? updates]) =>
      (new DestinatarioBuilder()..update(updates)).build();

  _$Destinatario._(
      {required this.nome, required this.email, required this.telefone})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(nome, 'Destinatario', 'nome');
    BuiltValueNullFieldError.checkNotNull(email, 'Destinatario', 'email');
    BuiltValueNullFieldError.checkNotNull(telefone, 'Destinatario', 'telefone');
  }

  @override
  Destinatario rebuild(void Function(DestinatarioBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DestinatarioBuilder toBuilder() => new DestinatarioBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Destinatario &&
        nome == other.nome &&
        email == other.email &&
        telefone == other.telefone;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, nome.hashCode), email.hashCode), telefone.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Destinatario')
          ..add('nome', nome)
          ..add('email', email)
          ..add('telefone', telefone))
        .toString();
  }
}

class DestinatarioBuilder
    implements Builder<Destinatario, DestinatarioBuilder> {
  _$Destinatario? _$v;

  String? _nome;
  String? get nome => _$this._nome;
  set nome(String? nome) => _$this._nome = nome;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _telefone;
  String? get telefone => _$this._telefone;
  set telefone(String? telefone) => _$this._telefone = telefone;

  DestinatarioBuilder();

  DestinatarioBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _nome = $v.nome;
      _email = $v.email;
      _telefone = $v.telefone;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Destinatario other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Destinatario;
  }

  @override
  void update(void Function(DestinatarioBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Destinatario build() {
    final _$result = _$v ??
        new _$Destinatario._(
            nome: BuiltValueNullFieldError.checkNotNull(
                nome, 'Destinatario', 'nome'),
            email: BuiltValueNullFieldError.checkNotNull(
                email, 'Destinatario', 'email'),
            telefone: BuiltValueNullFieldError.checkNotNull(
                telefone, 'Destinatario', 'telefone'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
