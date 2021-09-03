import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:paybook_app/data/repository/document_repository_model.dart';
import 'package:paybook_app/globals/serializers.dart';
import 'package:paybook_app/services/enum_book_type.dart';

part 'abstract_book_base_model.g.dart';

/// base class for all book models
///
/// must not be instantiated
@BuiltValue(instantiable: false)
abstract class AbstractBookBaseModel implements DocumentRepositoryModel {
  @BuiltValueField(wireName: 'book_type')
  EnumBookType get bookType;

  @BuiltValueField(wireName: 'name')
  String get name;

  @BuiltValueField(wireName: 'creation_date')
  DateTime get creationDate;

  @BuiltValueField(wireName: 'active')
  bool get active;

  @BuiltValueField(wireName: 'deactivation_date')
  DateTime? get deactivationDate;

  AbstractBookBaseModel rebuild(void Function(AbstractBookBaseModelBuilder) updates);

  AbstractBookBaseModelBuilder toBuilder();
}
