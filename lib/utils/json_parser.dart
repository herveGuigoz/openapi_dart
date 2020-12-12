import 'package:meta/meta.dart';

mixin JsonParser {
  static String parseSchema(Map<String, Object> json) {
    final ref = parseKey<String>(json, r'$ref');
    if (ref != null) return ref;

    final schema = parseKey<Map<String, Object>>(json, 'schema');

    if (schema != null && schema[r'$ref'] != null) {
      return schema[r'$ref'] as String;
    }

    if (schema != null && schema['items'] != null) {
      final items = schema['items'] as Map<String, Object>;
      return items[r'$ref'] as String;
    }

    final items = parseKey<Map<String, Object>>(json, 'items');

    if (items != null && items[r'$ref'] != null) {
      return items[r'$ref'] as String;
    }

    return null;
  }

  static T parseKey<T>(Map<String, Object> json, String key) {
    return json[key] != null ? json[key] as T : null;
  }

  static List<T> parseListOfMapByKey<T, S>({
    @required Map<String, Object> json,
    @required String key,
    @required T Function(String key, S value) builder,
  }) {
    if (json[key] == null) return <T>[];
    return parseListOfMap<T, S>(json[key] as Map<String, Object>, builder);
  }

  static List<T> parseListOfMap<T, S>(
    Map<String, Object> json,
    T Function(String key, S value) builder,
  ) {
    final list = <T>[];
    json.forEach((key, value) => list.add(builder(key, value as S)));

    return list;
  }

  static List<T> parseIterable<T>(Map<String, Object> json, String key) {
    return json[key] != null
        ? (json[key] as Iterable).map((dynamic e) => e as T).toList()
        : <T>[];
  }
}
