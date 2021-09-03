import 'package:cloud_firestore/cloud_firestore.dart';

import 'db_document.dart';

extension CollectionReferenceExtension on CollectionReference<Map<String, dynamic>> {
  Stream<List<DBDocument>> asDBDocumentListStream() => snapshots()
      .map((query) => query.docs.map((doc) => DBDocument.fromDocumentSnapshot(doc)).toList());

  Future<List<DBDocument>> asDBDocumentListFuture() =>
      get().then((query) => query.docs.map((doc) => DBDocument.fromDocumentSnapshot(doc)).toList());
}

extension QueryExtension on Query<Map<String, dynamic>> {
  Stream<List<DBDocument>> asDBDocumentListStream() => snapshots()
      .map((query) => query.docs.map((doc) => DBDocument.fromDocumentSnapshot(doc)).toList());

  Future<List<DBDocument>> asDBDocumentListFuture() =>
      get().then((query) => query.docs.map((doc) => DBDocument.fromDocumentSnapshot(doc)).toList());
}
