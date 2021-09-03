import 'package:cloud_firestore/cloud_firestore.dart';

class RepositoryProvider {
  static const String HOST = '10.0.2.2:9090';
  static const Settings emulatorSettings =
      Settings(host: HOST, sslEnabled: false, persistenceEnabled: true);

  static FirebaseFirestore _instance = FirebaseFirestore.instance;

  static void useEmulator() {
    _instance.settings = emulatorSettings;
  }

  static FirebaseFirestore get instance => _instance;
}
