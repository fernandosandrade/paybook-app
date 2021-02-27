import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paybook_app/data/models/book_abstract_base_model.dart';

import 'models_definition.dart';

part 'book_store_model.g.dart';

@JsonSerializable()
class BookStoreModel extends IBookStoreModel {
  @JsonKey(name: 'id_book')
  String idBook;

  @JsonKey(name: 'id_usuario')
  String idUsuario;

  @JsonKey(name: 'tipo_book')
  String tipoBook;

  @JsonKey(name: 'nome_book')
  String nomeBook;

  Map<String, dynamic> atributos;

  @JsonKey(ignore: true)
  DocumentReference reference;

  BookStoreModel(
      {@required this.idBook,
      @required this.idUsuario,
      @required this.tipoBook,
      @required this.nomeBook});

  factory BookStoreModel.fromJson(Map<String, dynamic> json) => _$BookStoreModelFromJson(json);

  static BookStoreModel fromAbstractBaseModel<T extends BookAbstractBaseModel>(T model) {
    var bookStoreModel = BookStoreModel.fromJson(model.toJson());
    bookStoreModel.idBook = model.idBook;
    bookStoreModel.idUsuario = model.idUsuario;
    bookStoreModel.tipoBook = model.tipoBook;
    bookStoreModel.nomeBook = model.nomeBook;
    return bookStoreModel;
  }

  BookStoreModel fromJson(Map<String, dynamic> json) {
    return BookStoreModel.fromJson(json);
  }

  Map<String, dynamic> toJson() => _$BookStoreModelToJson(this);
}
