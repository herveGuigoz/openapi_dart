part of 'models.dart';

mixin Parser {
  static String parseType(String type, [String item]) {
    if (type == null) return null;
    if (type == 'string') return 'String';
    if (type == 'integer') return 'int';
    if (type == 'boolean') return 'bool';
    // if (type == 'array') return 'List<${parseType(item)}>';
    return type;
  }
}

class Property {
  Property({
    this.name,
    this.type,
    this.readOnly,
    this.description,
    this.ref,
  });

  factory Property.fromJson(String name, Map<String, Object> json) {
    final ref = _parseRef(json);

    return Property(
      name: name,
      type: _parseTypeFromJson(name, json),
      readOnly: json['readOnly'] as bool,
      ref: ref,
      description:
          json['description'] != null ? json['description'] as String : null,
    );
  }

  static String _parseTypeFromJson(String name, Map<String, Object> json) {
    if (json['items'] != null) {
      final child = Map<String, String>.from(json['items']);

      if (child['type'] != null) {
        // is List<int> or List<String>
        return 'List<${Parser.parseType(child['type'])}>';
      }

      if (child[r'$ref'] != null) {
        return 'List<${name.substring(0, name.length - 1).capitalize()}>';
      }
    }

    final type = json['type'] != null ? json['type'] as String : null;

    // is bool, int or String
    if (type != null && (type != 'array')) return Parser.parseType(type);

    // is entity item
    return name.capitalize();
  }

  static String _parseRef(Map<String, Object> json) {
    if (json['items'] != null) {
      final child = json['items'] as Map<String, Object>;
      return child[r'$ref'] != null
          ? (child[r'$ref'] as String).allAfter('#/definitions/')
          : null;
    }

    return json[r'$ref'] != null
        ? (json[r'$ref'] as String).allAfter('#/definitions/')
        : null;
  }

  final String name;
  final String type;

  final bool readOnly;
  final String description;
  final String ref;

  @override
  String toString() {
    return '\n\n***$name***,\ntype: $type,\nreadOnly: $readOnly,\ndescription: $description,\nref: $ref';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Property &&
        other.name == name &&
        other.type == type &&
        other.readOnly == readOnly &&
        other.description == description &&
        other.ref == ref;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        type.hashCode ^
        readOnly.hashCode ^
        description.hashCode ^
        ref.hashCode;
  }
}

class Type {
  Type._({this.name, this.items, this.ref});

  final String name;
  final String items;
  final String ref;

  factory Type.fromJson(String json) {
    return Type._(name: Parser.parseType(json));
  }

  @override
  String toString() => name;
}
