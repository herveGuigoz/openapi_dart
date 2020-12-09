part of 'models.dart';

mixin Parser {
  static String parseType(String type, String item) {
    if (type == 'string') return 'String';
    if (type == 'integer') return 'int';
    if (type == 'boolean') return 'bool';
    if (type == 'array') return 'List<${parseType(item, null)}>';
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
    final ref = json[r'$ref'] != null
        ? (json[r'$ref'] as String).allAfter('#/definitions/')
        : null;

    final type = json['type'] as String ?? name.capitalize();
    final item = (json['items'] as Map<String, Object>)?.values?.first;

    return Property(
      name: name,
      type: Type(name: type, item: item),
      readOnly: json['readOnly'] as bool,
      ref: ref,
      description:
          json['description'] != null ? json['description'] as String : null,
    );
  }

  final String name;
  final Type type;

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
  Type({this.name, this.item});

  final String name;
  final String item;

  @override
  String toString() => Parser.parseType(name, item);
}
