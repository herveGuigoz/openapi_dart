import 'package:collection/collection.dart';
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
  String toString() => 'Path(iri: $iri, ressources: $ressources)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Path &&
        other.iri == iri &&
        listEquals(other.ressources, ressources);
  }

  @override
  int get hashCode => iri.hashCode ^ ressources.hashCode;
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
  String toString() {
    return 'Ressource(name: $name, tag: $tag, summary: $summary, responses: $responses)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Ressource &&
        other.name == name &&
        other.tag == tag &&
        other.summary == summary &&
        listEquals(other.responses, responses);
  }

  @override
  int get hashCode {
    return name.hashCode ^ tag.hashCode ^ summary.hashCode ^ responses.hashCode;
  }
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
  String toString() =>
      'Response(code: $code, description: $description, ref: $ref)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Response &&
        other.code == code &&
        other.description == description &&
        other.ref == ref;
  }

  @override
  int get hashCode => code.hashCode ^ description.hashCode ^ ref.hashCode;
}
