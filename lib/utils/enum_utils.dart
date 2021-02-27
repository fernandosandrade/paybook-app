class EnumUtils {
  static T getEnumFromString<T>(Iterable<T> values, String value) {
    return values.firstWhere((type) => type.toString() == value, orElse: () => null);
  }
}
