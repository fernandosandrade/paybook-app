import 'package:firebase_core/firebase_core.dart';
import 'package:paybook_app/data/repository/document_repository.dart';
import 'package:paybook_app/data/repository/repository_collection_path.dart';
import 'package:test/test.dart';

void main() async {
  await Firebase.initializeApp(
    name: 'plink',
    options: const FirebaseOptions(
        messagingSenderId: '269538875081',
        appId: '1:269538875081:android:771bf4efa0531e693f1f18',
        projectId: 'plink-2b309',
        apiKey: 'AIzaSyCmvaXxIWTV42bqO1nHrcMAB5q4EVIO4jg'),
  );
  print('inicializado');

  group('description', () {
    test('description', () async {
      var collectionPath = RepositoryCollectionPath.of(["cobrancas", "101", "111"]);
      var dbDocument = await DocumentRepository.onCollection(collectionPath).findByID("JE4RTA1UbozO4r6fIkMU");
      print(dbDocument);
    });
  });
}
