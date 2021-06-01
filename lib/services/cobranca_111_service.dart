import 'package:paybook_app/data/models/cobranca/cobranca_111_model.dart';
import 'package:paybook_app/data/repository/db_document.dart';
import 'package:paybook_app/data/repository/document_repository.dart';
import 'package:paybook_app/data/repository/repository_collection_path.dart';
import 'package:paybook_app/services/enum_tipo_book.dart';
import 'package:paybook_app/services/enum_tipo_cobranca.dart';

abstract class ICobranca111Service {
  Future save(Cobranca111Model model);
  Future delete(Cobranca111Model model);
  Future<Cobranca111Model?> findById(String bookId);
  // Future<List<Cobranca111Model?>> findByBookId(String bookId)
  Stream<List<Cobranca111Model?>> findByBookId(String bookId);
}

class Cobranca111Service implements ICobranca111Service {
  static const String COBRANCA_COLLECTION = 'cobrancas';
  //final CollectionReference collectionReference = RepositoryProvider.instance.collection(COBRANCA_SIMPLES_COLLECTION);
  //final DocumentRepository repository;
  final RepositoryCollectionPath collectionPath = RepositoryCollectionPath.of(
      [COBRANCA_COLLECTION, EnumTipoBook.B_101.codBook, EnumTipoCobranca.C_111.codCobranca]);

  @override
  Future save(Cobranca111Model cobranca) {
    return DocumentRepository.save(
        DBDocument.fromMap(data: cobranca.toMap(), repositoryCollectionPath: collectionPath));
    //var total = (await collectionReference.getDocuments()).documents.length;
    // if (model.reference == null) {
    //   model.reference = await collectionReference.add(model.toJson());
    // } else {
    //   model.reference.updateData(model.toJson());
    // }
  }

  Future delete(Cobranca111Model cobranca) {
    return DocumentRepository.delete(
        DBDocument.fromMap(data: cobranca.toMap(), repositoryCollectionPath: collectionPath));
    // return model.reference.delete();
  }

  @override
  Future<Cobranca111Model?> findById(String documentID) async {
    return DocumentRepository.onCollection(this.collectionPath)
        .findByID(documentID)
        .then((doc) => doc?.toObject(Cobranca111Model.serializer));
  }

  @override
  Stream<List<Cobranca111Model?>> findByBookId(String bookId) {
    return DocumentRepository.onCollection(this.collectionPath).findAllAsStream(field: "book_id", value: bookId).map(
        (docList) => docList.isNotEmpty
            ? docList.map((dbDoc) => dbDoc.toObject(Cobranca111Model.serializer)).toList()
            : List.empty());
  }

  // @override
  // Future<Cobranca111Model> getByIdCobranca(String idCobranca) {
  //   return collectionReference
  //       .where('id_cobranca', isEqualTo: idCobranca)
  //       .getDocuments()
  //       .then((value) => value.documents.isNotEmpty
  //           ? value.documents.map((doc) {
  //               var cobrancaSimplesModel = Cobranca111Model.fromJson(doc.data);
  //               cobrancaSimplesModel.reference = doc.reference;
  //               return cobrancaSimplesModel;
  //             }).first
  //           : throw Exception('nenhuma cobranca encontrada idCobranca=$idCobranca.'));
  // }

  //dispose will be called automatically
  @override
  void dispose() {}
}
