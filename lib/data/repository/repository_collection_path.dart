/// Provide a formatter for collections paths
class RepositoryCollectionPath {
  static final String _PATH_SEPARATOR = "/";
  final String path;

  RepositoryCollectionPath._internal({required this.path});

  /// Return paths formatted in a collection path. ex:
  /// ```
  /// ["cobranca", "101", "111"] => "cobranca/101/111"
  /// ```
  /// It is possible concatenate paths already formatted.
  /// ```
  /// ["cobranca/101", "111"] => "cobranca/101/111"
  /// ```
  factory RepositoryCollectionPath.of(List<String> paths) {
    paths.removeWhere((e) => e.isEmpty);
    return RepositoryCollectionPath._internal(path: paths.join(_PATH_SEPARATOR));
  }

  @override
  String toString() {
    return path;
  }
}
