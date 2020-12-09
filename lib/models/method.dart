part of 'models.dart';

class Get extends Method {
  Get({
    List<String> tags,
    String operationId,
    String summary,
    List<Response> responses,
  }) : super(
          name: 'get',
          tags: tags,
          operationId: operationId,
          summary: summary,
          responses: responses,
        );
  String get ref => responses
      ?.firstWhere((element) => element.code == 200, orElse: () => null)
      ?.schema
      ?.ref;
}

class Post extends Method {
  Post({
    List<String> tags,
    String operationId,
    String summary,
    List<Response> responses,
  }) : super(
          name: 'post',
          tags: tags,
          operationId: operationId,
          summary: summary,
          responses: responses,
        );
}

class Method {
  Method({
    this.name,
    this.tags,
    this.operationId,
    this.summary,
    this.responses,
  });

  factory Method.get({
    List<String> tags,
    String operationId,
    String summary,
    List<Response> responses,
  }) = Get;

  factory Method.post({
    List<String> tags,
    String operationId,
    String summary,
    List<Response> responses,
  }) = Post;

  factory Method.fromJson(String key, Map<String, Object> value) {
    final responses = <Response>[];
    (value['responses'] as Map<String, Object>).forEach((key, value) {
      responses.add(Response.fromJson(key, value));
    });

    if (key == 'get') {
      return Method.get(
        tags: (value['tags'] as List).map((e) => e as String).toList(),
        operationId: value['operationId'] as String,
        summary: value['summary'] as String,
        responses: responses,
      );
    }

    if (key == 'post') {
      return Method.post(
        tags: (value['tags'] as List).map((e) => e as String).toList(),
        operationId: value['operationId'] as String,
        summary: value['summary'] as String,
        responses: responses,
      );
    }

    return Method(
      name: key,
      tags: (value['tags'] as List).map((e) => e as String).toList(),
      operationId: value['operationId'] as String,
      summary: value['summary'] as String,
      responses: responses,
    );
  }

  final String name;
  final List<String> tags;
  final String operationId;
  final String summary;
  final List<Response> responses;

  @override
  String toString() {
    return 'Method(name: $name, tags: $tags, operationId: $operationId, summary: $summary, responses: $responses)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Method &&
        other.name == name &&
        listEquals(other.tags, tags) &&
        other.operationId == operationId &&
        other.summary == summary &&
        listEquals(other.responses, responses);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        tags.hashCode ^
        operationId.hashCode ^
        summary.hashCode ^
        responses.hashCode;
  }
}
