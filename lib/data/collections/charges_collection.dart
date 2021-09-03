import 'package:paybook_app/data/repository/repository_collection_path.dart';

import 'books_collection.dart';

class ChargesCollection extends BooksCollection {
  static const String collectionName = 'charges';

  String? chargeId;

  ChargesCollection({required String userId, required String bookId, this.chargeId})
      : super(userId: userId, bookId: bookId);

  /// ``/users/:user_id/books/:book_id/charges/:charge_id``
  RepositoryCollectionPath collectionPath() {
    return RepositoryCollectionPath.of(
        [super.collectionPath().path, collectionName, chargeId ?? '']);
    // return '${super.path()}/$collectionName/$chargeId';
  }
}
