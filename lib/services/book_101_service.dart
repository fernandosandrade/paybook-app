import 'package:paybook_app/data/models/book/book_101_model.dart';
import 'package:paybook_app/data/repository/db_document.dart';
import 'package:paybook_app/data/repository/document_repository.dart';
import 'package:paybook_app/data/repository/repository_collection_path.dart';

abstract class IBook101Service {
  Future save(Book101Model book);

  Future delete(Book101Model book);

  Stream<List<Book101Model?>> list(String idUsuario);

  Future<Book101Model?> getByBookId(String idBook);
// Future<Stream<Book101Model>> getByDocumentId(String documentId);
}

class Book101Service implements IBook101Service {
  static const String BOOKS_COLLECTION = 'books';
  final RepositoryCollectionPath booksCollectionPath = RepositoryCollectionPath.of([BOOKS_COLLECTION]);

  //final CollectionReference collectionReference = Firestore.instance.collection(BOOKS_COLLECTION);

  // BookService({required this.firestore});

  @override
  Future save(Book101Model book) async {
    DocumentRepository.save(DBDocument.fromMap(data: book.toMap(), repositoryCollectionPath: booksCollectionPath));
    //var total = (await collectionReference.getDocuments()).documents.length;
    // if (model.reference == null) {
    //   model.reference = await collectionReference.add(model.toJson());
    // } else {
    //   model.reference.updateData(model.toJson());
    // }
  }

  @override
  Future delete(Book101Model model) {
    return DocumentRepository.delete(
        DBDocument.fromMap(data: model.toMap(), repositoryCollectionPath: booksCollectionPath));
    // return model.reference.delete();
  }

  @override
  Stream<List<Book101Model?>> list(String idUsuario) {
    return DocumentRepository.onCollection(booksCollectionPath)
        .findAllAsStream(field: 'id_usuario', value: idUsuario)
        .map((docList) => docList.map((doc) => doc.toObject(Book101Model.serializer)).toList());
    // return collectionReference
    //     .where('id_usuario', isEqualTo: idUsuario)
    //     .snapshots()
    //     .map((query) => query.documents.map((doc) => BookStoreModel.fromJson(doc.data)).toList());
  }

  @override
  Future<Book101Model?> getByBookId(String idBook) async {
    return DocumentRepository.onCollection(booksCollectionPath)
        .findFirst(field: 'id_book', value: idBook)
        .then((doc) => doc?.toObject(Book101Model.serializer));
    // return collectionReference.where('id_book', isEqualTo: idBook).getDocuments().then((querySnapshot) {
    //   var doc = querySnapshot.documents.first;
    //   var bookStoreModel = BookStoreModel.fromJson(doc.data);
    //   bookStoreModel.reference = doc.reference;
    //   return bookStoreModel;
    // });
  }

// @override
// Future<Stream<Book101Model>> getByDocumentId(String documentId) async {
//   return collectionReference.document(documentId).snapshots().map((doc) => BookStoreModel.fromJson(doc.data));
// }
}
