part of 'models.dart';

class Response {
  Response({this.code, this.description, this.schema});

  final int code;
  final String description;
  final Schema schema;

  factory Response.fromJson(String key, Map<String, Object> value) {
    return Response(
      code: int.parse(key),
      description: value['description'] as String,
      schema: value['schema'] != null
          ? Schema.fromJson(value['schema'] as Map<String, Object>)
          : null,
    );
  }

  @override
  String toString() =>
      'Response(code: $code, description: $description, schema: $schema)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Response &&
        other.code == code &&
        other.description == description &&
        other.schema == schema;
  }

  @override
  int get hashCode => code.hashCode ^ description.hashCode ^ schema.hashCode;
}
