import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils.dart';

part 'definition.freezed.dart';

// Util to output List<...> as Dart Type.
abstract class Array {}

@freezed
abstract class Definition implements _$Definition {
  const Definition._();

  factory Definition({
    @required String name,
    String description,
    List<Property> properties,
    List<String> requiredProperties,
  }) = _Definition;

  factory Definition.fromKeyValue(String key, Map<String, Object> value) {
    final description =
        value['description'] != null ? value['description'] as String : null;

    final requiredProperties = value['required'] != null
        ? (value['required'] as Iterable)
            .map((dynamic e) => e as String)
            .toList()
        : <String>[];

    var properties = <Property>[];
    if (value['properties'] != null) {
      (value['properties'] as Map<String, Object>).forEach((key, value) {
        properties.add(
          Property.fromKeyValue(key, value as Map<String, Object>),
        );
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
}

@freezed
abstract class Property implements _$Property {
  const Property._();

  const factory Property({
    @required String name,
    @required Type type,
    Type subType,
    String ref,
    String description,
  }) = _Property;

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

  bool get hasDefinition => type == Definition || subType == Definition;
  bool get isArray => type == Array;

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
}
