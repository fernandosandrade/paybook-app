import 'package:nanoid/nanoid.dart';

class IdProvider {
  static String newId() {
    return nanoid();
  }
}
