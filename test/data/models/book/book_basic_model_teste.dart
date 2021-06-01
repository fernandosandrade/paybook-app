import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:paybook_app/data/models/book/book_basic_model.dart';
import 'package:paybook_app/data/repository/db_document.dart';
import 'package:paybook_app/data/repository/repository_collection_path.dart';
import 'package:paybook_app/globals/serializers.dart';
import 'package:paybook_app/services/enum_tipo_book.dart';

void main() {
  test('book basic model teste', () {
    var bookBasicModel = BookBasicModel((s) => s
      ..documentID = '123'
      ..idUsuario = 'user_id'
      ..nomeBook = 'nome_book'
      ..tipoBook = EnumTipoBook.B_101);
    var map = bookBasicModel.toMap();
    print(map);
    var dbDocument =
        DBDocument.fromMap(data: map, repositoryCollectionPath: RepositoryCollectionPath.of(["collection"]));
    var object = dbDocument.toObject(BookBasicModel.serializer);
    expect(bookBasicModel, object);
    expect('101', object!.tipoBook.codBook);

    String encode = json.encode(map);
    BookBasicModel? fromJson = serializers.fromJson(BookBasicModel.serializer, encode);
  });
}
