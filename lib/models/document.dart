part of 'models.dart';

class Document {
  Document({this.paths, this.definitions});

  final List<Path> paths;
  final List<Definition> definitions;

  Path getPathByName(String name) => paths.firstWhere(
        (element) => element.name == name,
        orElse: () => null,
      );

  Definition getDefinitionByName(String name) => definitions.firstWhere(
        (element) => element.name == name,
        orElse: () => null,
      );

  factory Document.fromRawJson(String str) {
    return Document.fromJson(json.decode(str));
  }

  factory Document.fromJson(Map<String, Object> json) {
    final paths = <Path>[];
    final definitions = <Definition>[];

    final pathsMap = (json['paths'] as Map<String, Object>);
    final definitionsMap = (json['definitions'] as Map<String, Object>);

    pathsMap.forEach(
      (key, value) => paths.add(Path.fromJson(key, value)),
    );

    definitionsMap.forEach(
      (key, value) => definitions.add(Definition.fromJson(key, value)),
    );

    return Document(
      paths: paths,
      definitions: definitions,
    );
  }

  @override
  String toString() => 'Doc(paths: $paths, definitions: $definitions)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Document &&
        listEquals(other.paths, paths) &&
        listEquals(other.definitions, definitions);
  }

  @override
  int get hashCode => paths.hashCode ^ definitions.hashCode;
}
