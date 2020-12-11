import 'package:meta/meta.dart';
import '../utils.dart';

class Path {
  Path({this.iri, this.ressources});

  final String iri;
  final List<Ressource> ressources;

  Ressource get getRessource => ressources.firstWhere(
        (ressource) => ressource.name == 'get',
        orElse: () => null,
      );

  factory Path.fromKeyValue(String key, Map<String, Object> value) {
    final ressources = <Ressource>[];
    value.forEach((key, value) {
      ressources.add(Ressource.fromKeyValue(key, value));
    });

    return Path(
      iri: key,
      ressources: ressources,
    );
  }

  @override
  String toString() => 'name: $iri, ressources: $ressources)';
}

class Ressource {
  Ressource({
    @required this.name,
    @required this.tag,
    this.summary,
    this.responses,
  });

  final String name;
  final String tag;
  final String summary;
  final List<Response> responses;

  factory Ressource.fromKeyValue(String key, Map<String, Object> value) {
    final summary = value['summary'] as String;
    final tags = value['tags'] as List;

    final responses = <Response>[];
    if (value['responses'] != null) {
      (value['responses'] as Map<String, Object>).forEach((key, value) {
        responses.add(Response.fromKeyValue(key, value));
      });
    }

    return Ressource(
      name: key,
      tag: tags[0] as String,
      summary: summary,
      responses: responses,
    );
  }

  @override
  String toString() => '$name: $tag';
}

class Response {
  Response({
    @required this.code,
    this.description,
    this.ref,
  });

  final int code;
  final String description;
  final String ref;

  factory Response.fromKeyValue(String key, Map<String, Object> value) {
    final description =
        value['description'] != null ? value['description'] as String : null;

    String ref;
    final schema =
        value['schema'] != null ? value['schema'] as Map<String, Object> : null;

    if (schema != null && schema[r'$ref'] != null) {
      ref = schema[r'$ref'] as String;
    } else if (schema != null) {
      final items = schema['items'] as Map<String, Object>;
      ref = items[r'$ref'] as String;
    }

    return Response(
      code: int.parse(key),
      description: description,
      ref: ref?.allAfter('#/definitions/'),
    );
  }

  @override
  String toString() => '\n$code, ref: $ref';
}
