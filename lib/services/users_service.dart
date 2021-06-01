import 'package:paybook_app/data/repository/db_document.dart';
import 'package:paybook_app/data/repository/document_repository.dart';
import 'package:paybook_app/data/repository/repository_collection_path.dart';

import '../data/models/user_model.dart';

abstract class IUserService {
  /// Retorna o usuario correspondente ao email informado. Caso nao possua cadastro, retorna [null]
  Future<UserModel?> getUser({required String email});
  Future save(UserModel user);
  Future delete({required String email});
}

class UserService implements IUserService {
  static const String USERS_COLLECTION = 'users';
  var userCollectionPath = RepositoryCollectionPath.of([USERS_COLLECTION]);

  @override
  Future<UserModel?> getUser({required String email}) async {
    return DocumentRepository.onCollection(userCollectionPath)
        .findFirst(field: "email", value: email)
        .then((dbDoc) => dbDoc?.toObject(UserModel.serializer));
  }

  @override
  Future save(UserModel user) async {
    var dbDocument = DBDocument.fromMap(data: user.toMap(), repositoryCollectionPath: userCollectionPath);
    return DocumentRepository.save(dbDocument);
  }

  @override
  Future delete({required String email}) {
    throw UnimplementedError();
  }
}
