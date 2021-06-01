import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paybook_app/data/repository/db_document.dart';
import 'package:paybook_app/data/repository/repository_provider.dart';

/// Defines access to documents for some collection from the repository
abstract class IRepositoryCollection {
  Future<DBDocument?> findByID(String documentID);
  Stream<DBDocument?> findByIDAsStream(String documentID);
  Future<DBDocument?> findFirst({required String field, required Object value});
  Future<List<DBDocument>> findAll({required String field, required Object value});
  Stream<List<DBDocument>> findAllAsStream({required String field, required Object value});
}

class RepositoryCollection implements IRepositoryCollection {
  /// collection referenced by this instance
  late final CollectionReference<Map<String, dynamic>> collectionReference;

  RepositoryCollection(String collectionPath) {
    this.collectionReference = RepositoryProvider.instance.collection(collectionPath);
  }

  @override
  Future<DBDocument?> findByID(String documentID) {
    return collectionReference.doc(documentID).get().then((doc) => DBDocument.fromDocumentSnapshot(doc));
  }

  @override
  Stream<DBDocument?> findByIDAsStream(String documentID) {
    return collectionReference.doc(documentID).snapshots().map((doc) => DBDocument.fromDocumentSnapshot(doc));
  }

  @override
  Future<DBDocument> findFirst({required String field, required Object value}) {
    return this
        .collectionReference
        .where(field, isEqualTo: value)
        .get()
        .then((query) => DBDocument.fromDocumentSnapshot(query.docs.first));
  }

  @override
  Future<List<DBDocument>> findAll({required String field, required Object value}) {
    return this
        .collectionReference
        .where(field, isEqualTo: value)
        .get()
        .then((query) => query.docs.map((doc) => DBDocument.fromDocumentSnapshot(doc)).toList());
  }

  @override
  Stream<List<DBDocument>> findAllAsStream({required String field, required Object value}) {
    return this
        .collectionReference
        .where(field, isEqualTo: value)
        .snapshots()
        .map((query) => query.docs.map((doc) => DBDocument.fromDocumentSnapshot(doc)).toList());
  }

  //dispose will be called automatically
  @override
  void dispose() {}

// @override
// Future<Stream<DBDocument>> getByDocumentId(String documentId) async {
//   return collectionReference.document(documentId).snapshots().map((doc) => Cobranca101Model.fromJson(doc.data));
// }

  // @override
  // Stream<List<DBDocument>> listByBookId(String bookId) {
  //   return collectionReference
  //       .where('id_book', isEqualTo: bookId)
  //       .snapshots()
  //       .map((query) => query.documents.map((doc) => Cobranca101Model.fromJson(doc?.data)).toList());
  // }

  // @override
  // Future<Cobranca101Model> getByIdCobranca(String idCobranca) {
  //   return collectionReference
  //       .where('id_cobranca', isEqualTo: idCobranca)
  //       .getDocuments()
  //       .then((value) => value.documents.isNotEmpty
  //           ? value.documents.map((doc) {
  //               var cobrancaSimplesModel = Cobranca101Model.fromJson(doc.data);
  //               cobrancaSimplesModel.reference = doc.reference;
  //               return cobrancaSimplesModel;
  //             }).first
  //           : throw Exception('nenhuma cobranca encontrada idCobranca=$idCobranca.'));
  // }

// @override
// Future save(DBDocument model) async {
//   //var total = (await collectionReference.getDocuments()).documents.length;
//   if (model.reference == null) {
//     model.reference = await collectionReference.add(model.toJson());
//   } else {
//     model.reference.updateData(model.toJson());
//   }
// }
}
