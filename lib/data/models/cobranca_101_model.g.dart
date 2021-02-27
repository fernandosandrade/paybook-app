// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cobranca_101_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cobranca101Model _$Cobranca101ModelFromJson(Map<String, dynamic> json) {
  return Cobranca101Model(
    idCobranca: json['id_cobranca'] as String,
    idBook: json['id_book'] as String,
    valor: (json['valor'] as num)?.toDouble(),
    dtCriacao: json['dt_criacao'] == null
        ? null
        : DateTime.parse(json['dt_criacao'] as String),
    dtVencimento: json['dt_vencimento'] == null
        ? null
        : DateTime.parse(json['dt_vencimento'] as String),
    destinatario: json['destinatario'] == null
        ? null
        : Destinatario.fromJson(json['destinatario'] as Map<String, dynamic>),
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$Cobranca101ModelToJson(Cobranca101Model instance) =>
    <String, dynamic>{
      'id_cobranca': instance.idCobranca,
      'id_book': instance.idBook,
      'dt_criacao': instance.dtCriacao?.toIso8601String(),
      'dt_vencimento': instance.dtVencimento?.toIso8601String(),
      'valor': instance.valor,
      'destinatario': instance.destinatario?.toJson(),
      'status': instance.status,
    };
