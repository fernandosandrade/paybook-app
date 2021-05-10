// ignore: implementation_imports
import 'package:cloud_firestore_platform_interface/src/set_options.dart';
import 'package:paybook_app/data/repository/db_document.dart';
import 'package:paybook_app/data/repository/repository_collection.dart';
import 'package:paybook_app/data/repository/repository_collection_path.dart';
import 'package:paybook_app/data/repository/repository_provider.dart';

/// Provide operations over document in static way
abstract class DocumentRepository {
  /// Save the document
  static Future<void> save(DBDocument document) {
    return RepositoryProvider.instance.doc(document.documentReference).set(document.data, SetOptions(merge: true));
  }

  /// Delete the document
  static Future<void> delete(DBDocument document) {
    return RepositoryProvider.instance.doc(document.documentReference).delete();
  }

  /// Return a collection for
  static IRepositoryCollection onCollection(RepositoryCollectionPath collectionPath) {
    return RepositoryCollection(collectionPath.path);
  }
}
