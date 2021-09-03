import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paybook_app/data/repository/extension_query.dart';
import 'package:paybook_app/data/repository/repository_provider.dart';

import 'db_document.dart';

/// Defines access to documents for some collection from the repository
abstract class IRepositoryCollection {
  Future<DBDocument?> findByID(String id);
  Stream<DBDocument?> findByIDAsStream(String id);
  Future<DBDocument?> findFirst({required String field, required Object value});
  Future<List<DBDocument>> findAll({required String field, required Object value});
  Stream<List<DBDocument>> findAllAsStream({required String field, required Object value});
  Stream<List<DBDocument>> listAllAsStream();
}

class RepositoryCollection implements IRepositoryCollection {
  /// collection referenced by this instance
  late final CollectionReference<Map<String, dynamic>> collectionReference;

  late final CollectionReference collectionReference2;

  RepositoryCollection(String collectionPath) {
    this.collectionReference = RepositoryProvider.instance.collection(collectionPath);
  }

  @override
  Future<DBDocument?> findByID(String id) {
    return collectionReference.doc(id).get().then((doc) => DBDocument.fromDocumentSnapshot(doc));
  }

  @override
  Stream<DBDocument?> findByIDAsStream(String id) {
    return collectionReference
        .doc(id)
        .snapshots()
        .map((doc) => DBDocument.fromDocumentSnapshot(doc));
  }

  @override
  Future<DBDocument?> findFirst({required String field, required Object value}) {
    return this.collectionReference.where(field, isEqualTo: value).get().then((query) {
      return query.docs.isNotEmpty ? DBDocument.fromDocumentSnapshot(query.docs.first) : null;
    });
  }

  @override
  Future<List<DBDocument>> findAll({required String field, required Object value}) {
    return this.collectionReference.where(field, isEqualTo: value).asDBDocumentListFuture();
  }

  @override
  Stream<List<DBDocument>> findAllAsStream({required String field, required Object value}) {
    return this.collectionReference.where(field, isEqualTo: value).asDBDocumentListStream();
  }

  @override
  Stream<List<DBDocument>> listAllAsStream() {
    return this.collectionReference.asDBDocumentListStream();
    // .snapshots()
    // .map((query) => query.docs.map((doc) => DBDocument.fromDocumentSnapshot(doc)).toList());
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
