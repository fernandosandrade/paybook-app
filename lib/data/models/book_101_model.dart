import 'package:json_annotation/json_annotation.dart';

import '../../modules/books/enum_tipo_de_book.dart';
import 'book_abstract_base_model.dart';
import 'book_store_model.dart';

part 'book_101_model.g.dart';

@JsonSerializable()
class Book101Model extends BookAbstractBaseModel {
  @JsonKey(name: 'vencimento')
  int vencimento;

  Book101Model({String idBook, String idUsuario, String nomeBook})
      : super(
            idBook: idBook,
            idUsuario: idUsuario,
            nomeBook: nomeBook,
            tipoBook: EnumTipoDeBook.SIMPLES.toString());

  factory Book101Model.fromJson(Map<String, dynamic> json) => _$Book101ModelFromJson(json);

  factory Book101Model.fromBookStoreModel(BookStoreModel bookStoreModel) {
    var instancia = Book101Model.fromJson(bookStoreModel.atributos);
    BookAbstractBaseModel.fromBookStoreModel(instancia, bookStoreModel);
    return instancia;
  }

  @override
  Book101Model fromJson(Map<String, dynamic> json) {
    return Book101Model.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$Book101ModelToJson(this);
}
