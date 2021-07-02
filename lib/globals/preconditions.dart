class Preconditions {
  Preconditions._();

  static T checkNotNull<T>(T? arg, String message) {
    if (arg == null) throw Exception(message);
    return arg;
  }
}
