import 'package:paybook_app/data/repository/repository_collection_path.dart';

class UsersCollection {
  static const String collectionName = 'users';

  String? userId;

  UsersCollection({this.userId});

  RepositoryCollectionPath collectionPath() {
    return RepositoryCollectionPath.of([collectionName, this.userId ?? '']);
    // return '/$collectionName/$userId';
  }
}
