import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

abstract class IUsersRepository {
  /// Retorna o usuario correspondente ao email informado. Caso nao possua cadastro, retorna [null]
  Future<UserModel> getUser({String email});
  Future save(UserModel user);
  Future delete({String email});
}

class UsersRepository implements IUsersRepository {
  static const String USERS_COLLECTION = 'users';

  final Firestore firestore;

  UsersRepository({@required this.firestore}) {
    assert(firestore != null);
  }

  @override
  Future<UserModel> getUser({String email}) async {
    var documents = (await Firestore.instance
            .collection(USERS_COLLECTION)
            .where("email", isEqualTo: email)
            .getDocuments())
        .documents;
    if (documents.length == 0) return null;
    if (documents.length > 1)
      throw MultipleUsersFoundException(filterAtribute: "email", filterValue: email);
    return documents.map((e) => UserModel.fromJson(e.data)).first;
  }

  @override
  Future save(UserModel model) async {
    if (model.reference == null) {
      model.reference = await Firestore.instance.collection(USERS_COLLECTION).add(model.toJson());
    } else {
      model.reference.updateData(model.toJson());
    }
  }

  @override
  Future delete({String email}) {
    throw UnimplementedError();
  }
}

class MultipleUsersFoundException implements Exception {
  String filterAtribute;
  String filterValue;
  MultipleUsersFoundException({this.filterAtribute, this.filterValue});

  String toString() =>
      "MultipleUsersFoundException: multiplos usuarios encontrados para uma mesma chave. campo=$filterAtribute valor=$filterValue";
}
