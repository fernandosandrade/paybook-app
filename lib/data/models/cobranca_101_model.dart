import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'destinatario.dart';
import 'models_definition.dart';

part 'cobranca_101_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Cobranca101Model extends ICobranca101Model {
  @JsonKey(name: 'id_cobranca')
  String idCobranca;

  @JsonKey(name: 'id_book')
  String idBook;

  @JsonKey(name: 'dt_criacao')
  DateTime dtCriacao;

  @JsonKey(name: 'dt_vencimento')
  DateTime dtVencimento;

  double valor;

  @JsonKey(name: 'destinatario')
  Destinatario destinatario;

  String status;

  @JsonKey(ignore: true)
  DocumentReference reference;

  Cobranca101Model({
    @required this.idCobranca,
    @required this.idBook,
    @required this.valor,
    @required this.dtCriacao,
    @required this.dtVencimento,
    @required this.destinatario,
    @required this.status,
  });

  factory Cobranca101Model.fromJson(Map<String, dynamic> json) => _$Cobranca101ModelFromJson(json);

  Map<String, dynamic> toJson() => _$Cobranca101ModelToJson(this);
}
