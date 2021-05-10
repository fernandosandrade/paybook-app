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

  @override
  Future<UserModel?> getUser({required String email}) async {
    return DocumentRepository.onCollection(RepositoryCollectionPath.of([USERS_COLLECTION]))
        .findFirst(field: "email", value: email)
        .then((dbDoc) => dbDoc?.toObject(UserModel.serializer));
    // var documents =
    //     (await RepositoryProvider.instance.collection(USERS_COLLECTION).where("email", isEqual To: email).getDocuments())
    //         .documents;
    // .map((e) => UserModel.fromJson(e.data));
    // return dbDocument?.map((e) => UserModel.fromJson(e.data)).first;
  }

  @override
  Future save(UserModel user) async {
    var dbDocument = DBDocument.fromMap(
        data: user.toMap(), repositoryCollectionPath: RepositoryCollectionPath.of([USERS_COLLECTION]));
    return DocumentRepository.save(dbDocument);
    // if (model.reference == null) {
    //   model.reference = await RepositoryProvider.instance.collection(USERS_COLLECTION).add(model.toJson());
    // } else {
    //   model.reference.updateData(model.toJson());
    // }
  }

  @override
  Future delete({required String email}) {
    throw UnimplementedError();
  }
}
