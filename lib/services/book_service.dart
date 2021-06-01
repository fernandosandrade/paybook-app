import 'package:paybook_app/data/models/book/book_basic_model.dart';
import 'package:paybook_app/data/repository/document_repository.dart';
import 'package:paybook_app/data/repository/repository_collection_path.dart';

abstract class IBookService {
  Future<BookBasicModel?> getById(String idBook);

  /// returns a stream whit books for the especified user.
  ///
  /// if pass null, return a ``List.empty``
  Stream<List<BookBasicModel?>> list(String idUsuario);
}

class BookService implements IBookService {
  static const String BOOKS_COLLECTION = 'books';
  final RepositoryCollectionPath booksCollectionPath = RepositoryCollectionPath.of([BOOKS_COLLECTION]);

  @override
  Stream<List<BookBasicModel?>> list(String? idUsuario) {
    if (idUsuario != null) {
      return DocumentRepository.onCollection(booksCollectionPath)
          .findAllAsStream(field: 'id_usuario', value: idUsuario)
          .map((docList) => docList.map((doc) => doc.toObject(BookBasicModel.serializer)).toList());
    } else {
      return Stream.value(List.empty());
    }
  }

  @override
  Future<BookBasicModel?> getById(String idBook) async {
    return DocumentRepository.onCollection(booksCollectionPath)
        .findByID(idBook)
        .then((doc) => doc?.toObject(BookBasicModel.serializer));
    // return collectionReference.where('id_book', isEqualTo: idBook).getDocuments().then((querySnapshot) {
    //   var doc = querySnapshot.documents.first;
    //   var bookStoreModel = BookStoreModel.fromJson(doc.data);
    //   bookStoreModel.reference = doc.reference;
    //   return bookStoreModel;
    // });
  }
}
