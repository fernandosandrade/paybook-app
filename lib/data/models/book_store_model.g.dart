// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_store_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookStoreModel _$BookStoreModelFromJson(Map<String, dynamic> json) {
  return BookStoreModel(
    idBook: json['id_book'] as String,
    idUsuario: json['id_usuario'] as String,
    tipoBook: json['tipo_book'] as String,
    nomeBook: json['nome_book'] as String,
  )..atributos = json['atributos'] as Map<String, dynamic>;
}

Map<String, dynamic> _$BookStoreModelToJson(BookStoreModel instance) =>
    <String, dynamic>{
      'id_book': instance.idBook,
      'id_usuario': instance.idUsuario,
      'tipo_book': instance.tipoBook,
      'nome_book': instance.nomeBook,
      'atributos': instance.atributos,
    };
