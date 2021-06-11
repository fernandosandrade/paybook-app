class Preconditions {
  Preconditions._();

  static String checkNotNull(String? arg, String message) {
    if (arg == null) throw Exception(message);
    return arg;
  }
}
