import 'package:built_value/serializer.dart';
import 'package:logging/logging.dart';
import 'package:paybook_app/data/collections/books_collection.dart';
import 'package:paybook_app/data/models/book/abstract_book_base_model.dart';
import 'package:paybook_app/data/repository/db_document.dart';
import 'package:paybook_app/data/repository/document_repository.dart';

abstract class IBookService<T extends AbstractBookBaseModel> {
  Future<void> save(T book);

  Future<void> delete(T book);

  Future<T?> getById(String idBook);

  /// returns a stream whit all active books for the user.
  ///
  /// if pass null, return a ``List.empty``
  Stream<List<T?>> listAllActives();
}

class BookService<T extends AbstractBookBaseModel> implements IBookService<T> {
  final log = Logger('BookService');

  final BooksCollection _booksCollection;

  final Serializer<T> _serializer;

  BookService({required BooksCollection booksCollection, required Serializer<T> serializer})
      : this._booksCollection = booksCollection,
        this._serializer = serializer;

  @override
  Future<void> save(T book) {
    log.info('saving $book on ${_booksCollection.collectionPath()}');
    return DocumentRepository.save(DBDocument.fromMap(
        data: book.toMap(), repositoryCollectionPath: _booksCollection.collectionPath()));
  }

  @override
  Future<void> delete(T book) {
    log.info('deleting $book');
    return DocumentRepository.delete(DBDocument.fromMap(
        data: book.toMap(), repositoryCollectionPath: _booksCollection.collectionPath()));
  }

  @override
  Stream<List<T?>> listAllActives() {
    return DocumentRepository.onCollection(_booksCollection.collectionPath())
        .findAllAsStream(field: 'active', value: true)
        .map((docList) => docList.map((doc) => doc.toObject(this._serializer)).toList());
  }

  @override
  Future<T?> getById(String idBook) async {
    return DocumentRepository.onCollection(_booksCollection.collectionPath())
        .findByID(idBook)
        .then((doc) => doc?.toObject(this._serializer));
  }
}
