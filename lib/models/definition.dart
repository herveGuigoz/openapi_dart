part of 'models.dart';

class Definition {
  Definition({
    this.name,
    this.type,
    this.properties,
  });

  factory Definition.fromJson(String name, Map<String, Object> json) {
    final properties = <Property>[];

    if (json['properties'] != null) {
      (json['properties'] as Map<String, Object>).forEach((key, value) {
        properties.add(Property.fromJson(key, value));
      });
    }

    return Definition(
      name: name,
      type: json['type'] as String,
      properties: properties,
    );
  }

  final String name;
  final String type;
  final List<Property> properties;

  List<String> get refs {
    if (properties == null) return null;

    final refs = <String>[];

    for (final property in properties) {
      if (property?.ref == null) continue;
      refs.add(property.ref);
    }

    return refs;
  }

  @override
  String toString() =>
      'Definition(\nname: $name,\ntype: $type,\nproperties: $properties\n)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Definition &&
        other.name == name &&
        other.type == type &&
        listEquals(other.properties, properties);
  }

  @override
  int get hashCode => name.hashCode ^ type.hashCode ^ properties.hashCode;
}
