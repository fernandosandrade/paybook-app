import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'book_store_model.dart';
import 'models_definition.dart';

abstract class BookAbstractBaseModel extends IBookStoreModel {
  @JsonKey(ignore: true)
  String idBook;

  @JsonKey(ignore: true)
  String idUsuario;

  @JsonKey(ignore: true)
  String tipoBook;

  @JsonKey(ignore: true)
  String nomeBook;

  BookAbstractBaseModel(
      {@required this.idBook,
      @required this.idUsuario,
      @required this.tipoBook,
      @required this.nomeBook});

  Map<String, dynamic> toJson();

  fromJson(Map<String, dynamic> json);

  static fromBookStoreModel<T extends BookAbstractBaseModel>(
      T instance, BookStoreModel bookStoreModel) {
    instance.idBook = bookStoreModel.idBook;
    instance.idUsuario = bookStoreModel.idUsuario;
    instance.tipoBook = bookStoreModel.tipoBook;
    instance.nomeBook = bookStoreModel.nomeBook;
  }
}
