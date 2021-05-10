import 'package:cloud_firestore/cloud_firestore.dart';

class RepositoryProvider {
  RepositoryProvider._();

  static FirebaseFirestore get instance => FirebaseFirestore.instance;
}
