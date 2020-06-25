class AssertUtil {
  final String _basePath;

  const AssertUtil(this._basePath);

  String named(String name) {
    return this._basePath + name;
  }
}