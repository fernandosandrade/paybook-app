import 'package:flutter_test/flutter_test.dart';
import 'package:paybook_app/data/models/cobranca/cobranca_111_model.dart';
import 'package:paybook_app/data/models/destinatario.dart';

void main() {
  test('serialization/deserialization test', () {
    var destinatario = Destinatario((d) => d
      ..nome = "fernando"
      ..email = "email@gmail.com"
      ..telefone = "999888777");

    var cobranca111model = Cobranca111Model((s) => s
      ..documentID = "123"
      ..idBook = "book_id_123"
      ..valor = 1
      ..dtCriacao = DateTime.now().toUtc()
      ..dtVencimento = DateTime.now().add(Duration(days: 1)).toUtc()
      ..status = "TESTE"
      ..destinatario = Destinatario((d) => d
        ..nome = "fernando"
        ..email = "email@gmail.com"
        ..telefone = "999888777").toBuilder());

    var map = cobranca111model.toMap();
    var dbDocument =
        DBDocument.fromMap(data: map, repositoryCollectionPath: RepositoryCollectionPath.of(["collection"]));
    var object = dbDocument.toObject(Cobranca111Model.serializer);
    expect(cobranca111model, object);

    // print(json);
    // print(map);
    // print(dbDocument);
  });
}
