import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import '../utils.dart';

// Util to output List<...> as Dart Type.
class Array {}

class Definition {
  Definition({
    @required this.name,
    this.description,
    this.properties,
    this.requiredProperties,
  });

  final String name;
  final String description;
  final List<Property> properties;
  final List<String> requiredProperties;

  factory Definition.fromKeyValue(String key, Map<String, Object> value) {
    final description =
        value['description'] != null ? value['description'] as String : null;

    final requiredProperties = value['required'] != null
        ? (value['required'] as Iterable).map((e) => e as String).toList()
        : <String>[];

    var properties = <Property>[];
    if (value['properties'] != null) {
      (value['properties'] as Map<String, Object>).forEach((key, value) {
        properties.add(Property.fromKeyValue(key, value));
      });
    }

    return Definition(
      name: key,
      description: description?.isNotEmpty ?? false ? description : null,
      requiredProperties: requiredProperties,
      properties: properties,
    );
  }

  String get entity {
    final matchs = RegExp(r'[A-z|0-9]*').firstMatch(name);
    return matchs.group(0);
  }

  @override
  String toString() {
    return 'Definition(name: $name, description: $description, properties: $properties, requiredProperties: $requiredProperties)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Definition &&
        other.name == name &&
        other.description == description &&
        listEquals(other.properties, properties) &&
        listEquals(other.requiredProperties, requiredProperties);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        properties.hashCode ^
        requiredProperties.hashCode;
  }
}

class Property {
  Property({
    @required this.name,
    @required this.type,
    this.subType,
    this.ref,
    this.description,
  });

  final String name;
  final Type type;
  final Type subType;
  final String ref;
  final String description;

  bool get hasDefinition => type == Definition || subType == Definition;
  bool get isArray => type == Array;

  factory Property.fromKeyValue(String key, Map<String, Object> value) {
    final description =
        value['description'] != null ? value['description'] as String : null;

    var ref = value[r'$ref'] != null ? value[r'$ref'] as String : null;
    if (ref == null && value['items'] != null) {
      if ((value['items'] as Map<String, Object>)[r'$ref'] != null) {
        ref = (value['items'] as Map<String, Object>)[r'$ref'] as String;
      }
    }

    final type = _getType(value);
    Type subType;

    final items =
        value['items'] != null ? value['items'] as Map<String, Object> : null;

    if (items != null) {
      subType = _getType(items);
    }

    return Property(
      name: key,
      type: type,
      subType: subType,
      ref: ref?.allAfter('#/definitions/'),
      description: description,
    );
  }

  static Type _getType(Map<String, Object> value) {
    final type = value['type'] as String;
    final ref = value[r'$ref'] != null ? value[r'$ref'] as String : null;

    if (ref != null) return Definition;
    if (type == 'string') return String;
    if (type == 'integer') return int;
    if (type == 'boolean') return bool;
    if (type == 'array') return Array;

    return Object;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Property &&
        other.name == name &&
        other.type == type &&
        other.subType == subType &&
        other.ref == ref &&
        other.description == description;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        type.hashCode ^
        subType.hashCode ^
        ref.hashCode ^
        description.hashCode;
  }

  @override
  String toString() {
    return 'Property(name: $name, type: $type, subType: $subType, ref: $ref, description: $description)';
  }
}
