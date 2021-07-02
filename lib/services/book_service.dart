import 'package:built_value/serializer.dart';
import 'package:paybook_app/data/models/book/book_base_model.dart';
import 'package:paybook_app/data/models/book/book_basic_model.dart';
import 'package:paybook_app/data/repository/document_repository.dart';
import 'package:paybook_app/data/repository/repository_collection_path.dart';

abstract class IBookService<T extends BookBaseModel> {
  Future<T?> getById(String idBook);

  /// returns a stream whit books for the especified user.
  ///
  /// if pass null, return a ``List.empty``
  Stream<List<T?>> list(String idUsuario);
}

class BookService<T extends BookBaseModel> implements IBookService {
  static const String BOOKS_COLLECTION = 'books';
  final RepositoryCollectionPath _booksCollectionPath =
      RepositoryCollectionPath.of([BOOKS_COLLECTION]);

  final Serializer<T> _serializar;

  BookService(Serializer<T> serializer) : this._serializar = serializer;

  @override
  Stream<List<T?>> list(String idUsuario) {
    // if (idUsuario != null) {
    return DocumentRepository.onCollection(_booksCollectionPath)
        .findAllAsStream(field: 'id_usuario', value: idUsuario)
        .map((docList) => docList.map((doc) => doc.toObject(this._serializar)).toList());
    // } else {
    //   return Stream.value(List.empty());
    // }
  }

  @override
  Future<T?> getById(String idBook) async {
    return DocumentRepository.onCollection(_booksCollectionPath)
        .findByID(idBook)
        .then((doc) => doc?.toObject(this._serializar));
    // return collectionReference.where('id_book', isEqualTo: idBook).getDocuments().then((querySnapshot) {
    //   var doc = querySnapshot.documents.first;
    //   var bookStoreModel = BookStoreModel.fromJson(doc.data);
    //   bookStoreModel.reference = doc.reference;
    //   return bookStoreModel;
    // });
  }
}
