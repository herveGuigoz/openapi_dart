import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/json_parser.dart';
import '../utils/string_extensions.dart';

part 'definition.freezed.dart';

extension DefinitionIterable on Iterable<Definition> {
  Definition byName(String name) =>
      firstWhere((def) => def.name == name, orElse: () => null);
}

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

  factory Definition.fromKeyValue(String key, Map<String, Object> json) {
    final description = JsonParser.parseKey<String>(json, 'description');
    final requiredProps = JsonParser.parseIterable<String>(json, 'required');

    return Definition(
      name: key,
      description: description?.isNotEmpty ?? false ? description : null,
      requiredProperties: requiredProps,
      properties: JsonParser.parseListOfMapByKey<Property, Map<String, Object>>(
        json: json,
        key: 'properties',
        builder: (key, value) => Property.fromKeyValue(key, value),
      )
          .map((property) => requiredProps.contains(property.name)
              ? property.copyWith(isRequired: true)
              : property)
          .toList(),
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
    @Default(false) bool isRequired,
  }) = _Property;

  factory Property.fromKeyValue(String key, Map<String, Object> value) {
    var ref = JsonParser.parseSchema(value);
    final items = JsonParser.parseKey<Map<String, Object>>(value, 'items');

    return Property(
      name: key,
      type: _getType(value),
      subType: items != null ? _getType(items) : null,
      ref: ref?.allAfter('#/definitions/'),
      description: JsonParser.parseKey(value, 'description'),
    );
  }

  bool get hasDefinition => type == Definition || subType == Definition;
  bool get isArray => type == Array;

  static Type _getType(Map<String, Object> json) {
    final type = json['type'] as String;
    final ref = JsonParser.parseKey<String>(json, r'$ref');

    if (ref != null) return Definition;
    if (type == 'string') return String;
    if (type == 'integer') return int;
    if (type == 'boolean') return bool;
    if (type == 'array') return Array;

    return Object;
  }
}
