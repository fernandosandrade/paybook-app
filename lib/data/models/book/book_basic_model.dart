import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:paybook_app/globals/serializers.dart';
import 'package:paybook_app/services/enum_book_type.dart'; // must import

import 'abstract_book_base_model.dart';

part 'book_basic_model.g.dart';

/// This class has all field inherit from book base_model.
/// This is useful to provide a generic class with all common fields from book models
abstract class BookBasicModel extends Object
    implements AbstractBookBaseModel, Built<BookBasicModel, BookBasicModelBuilder> {
  static Serializer<BookBasicModel> get serializer => _$bookBasicModelSerializer;

  BookBasicModel._();
  factory BookBasicModel([void Function(BookBasicModelBuilder) updates]) = _$BookBasicModel;

  // static BookBasicModel fromBaseModel<T extends BookBaseModel>(T baseModel) {
  //   return BookBasicModel((s) => s
  //     ..id = baseModel.id
  //     ..tipoBook = baseModel.tipoBook
  //     ..nomeBook = baseModel.nomeBook
  //     ..idUsuario = baseModel.idUsuario);
  // }

  Map<String, dynamic> toMap() {
    var serialized =
        serializers.serializeWith(BookBasicModel.serializer, this) as Map<String, dynamic>;
    return Map<String, dynamic>.from(serialized);
  }
}
