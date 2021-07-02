import 'package:built_value/serializer.dart';
import 'package:paybook_app/data/models/book/book_base_model.dart';
import 'package:paybook_app/data/repository/db_document.dart';
import 'package:paybook_app/data/repository/document_repository.dart';
import 'package:paybook_app/data/repository/document_repository_model.dart';
import 'package:paybook_app/data/repository/repository_collection_path.dart';
import 'package:paybook_app/services/enum_tipo_book.dart';
import 'package:paybook_app/services/enum_tipo_cobranca.dart';

abstract class ICobrancaService<T extends DocumentRepositoryModel> {
  Future save(T model);

  Future delete(T model);

  /// find charge by id
  Future<T?> findById(String id);

  /// find charge from the book_id it is associated with
  Stream<List<T?>> findByBookId(String bookId);
}

class CobrancaService<T extends DocumentRepositoryModel>
    implements ICobrancaService<T> {
  static const String COBRANCA_COLLECTION = 'cobrancas';

  final RepositoryCollectionPath collectionPath;

  final EnumTipoBook book;

  final EnumTipoCobranca cobranca;

  final Serializer<T> serializer;

  CobrancaService(
      {required this.book, required this.cobranca, required this.serializer})
      : this.collectionPath = RepositoryCollectionPath.of(
            [COBRANCA_COLLECTION, book.wireNumber, cobranca.wireNumber]);

  @override
  Future save(T model) {
    return DocumentRepository.save(DBDocument.fromMap(
        data: model.toMap(), repositoryCollectionPath: collectionPath));
  }

  @override
  Future delete(T model) {
    return DocumentRepository.delete(DBDocument.fromMap(
        data: model.toMap(), repositoryCollectionPath: collectionPath));
  }

  @override
  Future<T?> findById(String id) {
    return DocumentRepository.onCollection(this.collectionPath)
        .findByID(id)
        .then((doc) => doc?.toObject(this.serializer));
  }

  @override
  Stream<List<T?>> findByBookId(String bookId) {
    return DocumentRepository.onCollection(this.collectionPath)
        .findAllAsStream(field: BookBaseModel.ID_BOOK_FIELD_NAME, value: bookId)
        .map((docList) => docList.isNotEmpty
            ? docList.map((dbDoc) => dbDoc.toObject(this.serializer)).toList()
            : List.empty());
  }
}
