import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:paybook_app/data/repository/document_repository_model.dart';
import 'package:paybook_app/globals/serializers.dart';
import 'package:paybook_app/services/enum_tipo_book.dart';

part 'book_base_model.g.dart';

/// base class for all book models
///
/// must not be instantiated
@BuiltValue(instantiable: false)
abstract class BookBaseModel implements DocumentRepositoryModel {
  static const String ID_BOOK_FIELD_NAME = "id_book";

  @BuiltValueField(wireName: "id_usuario")
  String get idUsuario;

  @BuiltValueField(wireName: 'tipo_book')
  EnumTipoBook get tipoBook;

  @BuiltValueField(wireName: 'nome_book')
  String get nomeBook;

  BookBaseModel rebuild(void Function(BookBaseModelBuilder) updates);

  BookBaseModelBuilder toBuilder();
}
