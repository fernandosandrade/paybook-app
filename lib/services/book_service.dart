import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/models/book_store_model.dart';

abstract class IBookService {
  Stream<List<BookStoreModel>> list(String idUsuario);
  Future save(BookStoreModel model);
  Future delete(BookStoreModel model);
  Future<BookStoreModel> getByBookId(String idBook);
  Future<Stream<BookStoreModel>> getByDocumentId(String documentId);
}

class BookService implements IBookService {
  static const String BOOKS_COLLECTION = 'books';
  final Firestore firestore;
  final CollectionReference collectionReference = Firestore.instance.collection(BOOKS_COLLECTION);

  BookService({required this.firestore});

  @override
  Stream<List<BookStoreModel>> list(String idUsuario) {
    return collectionReference
        .where('id_usuario', isEqualTo: idUsuario)
        .snapshots()
        .map((query) => query.documents.map((doc) => BookStoreModel.fromJson(doc.data)).toList());
  }

  @override
  Future<BookStoreModel> getByBookId(String idBook) async {
    return collectionReference.where('id_book', isEqualTo: idBook).getDocuments().then((querySnapshot) {
      var doc = querySnapshot.documents.first;
      var bookStoreModel = BookStoreModel.fromJson(doc.data);
      bookStoreModel.reference = doc.reference;
      return bookStoreModel;
    });
  }

  @override
  Future<Stream<BookStoreModel>> getByDocumentId(String documentId) async {
    return collectionReference.document(documentId).snapshots().map((doc) => BookStoreModel.fromJson(doc.data));
  }

  @override
  Future save(BookStoreModel model) async {
    //var total = (await collectionReference.getDocuments()).documents.length;

    if (model.reference == null) {
      model.reference = await collectionReference.add(model.toJson());
    } else {
      model.reference.updateData(model.toJson());
    }
  }

  Future delete(BookStoreModel model) {
    return model.reference.delete();
  }
}
