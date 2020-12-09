part of 'models.dart';

class Path {
  Path({this.name, this.methods});

  final String name;
  final List<Method> methods;

  bool get hasMethodGET => methods.whereType<Get>().isNotEmpty;
  Get get methodGET => hasMethodGET ? methods.whereType<Get>().first : null;

  factory Path.fromJson(String key, Map<String, Object> value) {
    final methods = <Method>[];
    value.forEach((key, value) => methods.add(Method.fromJson(key, value)));

    return Path(name: key, methods: methods);
  }

  @override
  String toString() => 'Path(name: $name, methods: $methods)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Path &&
        other.name == name &&
        listEquals(other.methods, methods);
  }

  @override
  int get hashCode => name.hashCode ^ methods.hashCode;
}
