part of 'models.dart';

class Schema {
  Schema({this.type, this.ref});

  factory Schema.fromJson(Map<String, Object> value) {
    String ref;

    if (value['items'] != null) {
      ref = (value['items'] as Map<String, Object>).values.first as String;
    } else if (value[r'$ref'] != null) {
      ref = value[r'$ref'] as String;
    }

    return Schema(
      type: value['type'] as String,
      ref: ref?.allAfter('#/definitions/'),
    );
  }

  final String type;
  final String ref;

  @override
  String toString() => 'Schema(type: $type, ref: $ref)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Schema && other.type == type && other.ref == ref;
  }

  @override
  int get hashCode => type.hashCode ^ ref.hashCode;
}
