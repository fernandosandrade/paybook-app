import 'package:flutter_test/flutter_test.dart';
import 'package:paybook_app/data/repository/repository_collection_path.dart';

void main() {
  test('repository collection path test', () {
    var collectionReference = RepositoryCollectionPath.of(["cobranca", "101"]);
    expect("cobranca/101", collectionReference.path);
    var collectionReference2 = RepositoryCollectionPath.of([collectionReference.path, "111"]);
    expect("cobranca/101/111", collectionReference2.path);
    var collectionReference3 = RepositoryCollectionPath.of(["cobranca/101/111"]);
    expect("cobranca/101/111", collectionReference3.path);
  });
}
