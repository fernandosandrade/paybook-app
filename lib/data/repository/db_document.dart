import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paybook_app/data/repository/document_repository_model.dart';
import 'package:paybook_app/data/repository/repository_collection_path.dart';
import 'package:paybook_app/globals/serializers.dart';

/// Represent a document from repository
class DBDocument {
  /// Remote reference to that document.
  ///
  /// Composed of collection_path + document_id. ex:
  /// ```
  /// documentReference:   cobrancas/101/111/O5OUe1ZKbmz5VNM9R7z4
  /// collection:          cobrancas/101/111/
  /// id:                  O5OUe1ZKbmz5VNM9R7z4
  /// ```
  /// In firestore, a document reference also is a collection reference (documents can store collections)
  final String documentReference;

  /// map that represents the json data of the document
  final Map<String, dynamic> data;

  DBDocument._internal(this.data, this.documentReference);

  /// creates a [DBDocument] from some implementation of [DocumentSnapshot]
  /// uses to create a DBDocument from a document read from repository
  static DBDocument fromDocumentSnapshot<T extends DocumentSnapshot<Map<String, dynamic>>>(
      T documentSnapshot) {
    return DBDocument._internal(documentSnapshot.data()!, documentSnapshot.reference.path);
  }

  /// creates a [DBDocument] with the specific parameters
  ///
  /// this method retrieves the document id from the map
  static DBDocument fromMap(
      {required Map<String, dynamic> data,
      required RepositoryCollectionPath repositoryCollectionPath}) {
    var id = data.remove(DocumentRepositoryModel.ID);
    assert(id != null, 'id must not be null');
    return DBDocument._internal(
        data, RepositoryCollectionPath.of([repositoryCollectionPath.path, id]).path);
  }

  /// deserializes this instance with the specified serializer
  T? toObject<T extends DocumentRepositoryModel>(Serializer<T> serializer) {
    this.data.addAll({DocumentRepositoryModel.ID: this.id()});
    return serializers.deserializeWith(serializer, data);
  }

  /// Returns the corresponding ID of this document reference.
  String id() => this.documentReference.substring(this.documentReference.lastIndexOf('/') + 1);

  /// Returns de corresponding collection of this document reference.
  String collection() =>
      this.documentReference.substring(0, this.documentReference.lastIndexOf('/'));

  @override
  String toString() {
    return 'DBDocument{documentReference: $documentReference, data: $data}';
  }
}
