import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:paybook_app/globals/serializers.dart';
import 'package:paybook_app/services/enum_book_type.dart';

import 'abstract_book_base_model.dart';

part 'book_101_model.g.dart';

abstract class Book101Model extends Object
    implements AbstractBookBaseModel, Built<Book101Model, Book101ModelBuilder> {
  static Serializer<Book101Model> get serializer => _$book101ModelSerializer;

  Book101Model._();
  factory Book101Model([void Function(Book101ModelBuilder) updates]) = _$Book101Model;

  // @BuiltValueField(wireName: "field")
  // String get field;

  Map<String, dynamic> toMap() {
    var serialized =
        serializers.serializeWith(Book101Model.serializer, this) as Map<String, dynamic>;
    return Map<String, dynamic>.from(serialized);
  }
}
