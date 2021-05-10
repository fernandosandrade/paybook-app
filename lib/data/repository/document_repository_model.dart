import 'package:built_value/built_value.dart';
import 'package:paybook_app/data/repository/db_document.dart';

part 'document_repository_model.g.dart';

/// Base model for all repository documents.
@BuiltValue(instantiable: false)
abstract class DocumentRepositoryModel {
  static const String DOCUMENT_ID = "document_id";

  /// The document id.
  ///
  /// This field is 'virtual'. It is not effectively serialized/deserialized.
  ///
  /// When the object is converted to [DBDocument], it is removed from the ``Map data`` and transformed to the repository document id.
  ///
  /// The reverse occurs whit the deserialization: repository document id is included to map by the [DBDocument toObject] and used in deserialization.
  @BuiltValueField(wireName: DOCUMENT_ID)
  String get documentID;
}
