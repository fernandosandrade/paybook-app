import 'package:paybook_app/data/collections/users_collection.dart';
import 'package:paybook_app/data/repository/repository_collection_path.dart';

class BooksCollection extends UsersCollection {
  static const String collectionName = 'books';

  String? bookId;

  BooksCollection({required String userId, this.bookId}) : super(userId: userId);

  /// ``/users/:user_id/books/:book_id``
  RepositoryCollectionPath collectionPath() {
    return RepositoryCollectionPath.of(
        [super.collectionPath().path, collectionName, this.bookId ?? '']);
    // return '${super.path()}/$collectionName/$bookId';
  }
}
