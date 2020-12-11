import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils.dart';

part 'path.freezed.dart';

@freezed
abstract class Path implements _$Path {
  const Path._();

  const factory Path({
    @required String iri,
    @required List<Ressource> ressources,
  }) = _Path;

  factory Path.fromKeyValue(String key, Map<String, Object> value) {
    final ressources = <Ressource>[];
    value.forEach((key, value) {
      ressources.add(Ressource.fromKeyValue(key, value as Map<String, Object>));
    });

    return Path(
      iri: key,
      ressources: ressources,
    );
  }

  Ressource getRessourceByMethod(String method) {
    final _method = method.toLowerCase();

    if (!['get', 'post', 'put', 'delete'].contains(_method)) {
      throw Exception('Method $_method not available');
    }

    return ressources.firstWhere(
      (ressource) => ressource.name == _method,
      orElse: () => throw ArgumentError(
        // ignore: lines_longer_than_80_chars
        '${_method.toUpperCase()} method not found in specifications. ${ressources.map((e) => e.name.toUpperCase()).toList()}',
      ),
    );
  }
}

@freezed
abstract class Ressource implements _$Ressource {
  const Ressource._();

  const factory Ressource({
    @required String name,
    @required String tag,
    @required String operationId,
    String summary,
    List<Response> responses,
    // this.requests,
  }) = _Ressource;

  factory Ressource.fromKeyValue(String key, Map<String, Object> value) {
    final summary = value['summary'] as String;
    final tags = value['tags'] as List;
    final operationId = value['operationId'] as String;

    final responses = <Response>[];
    if (value['responses'] != null) {
      (value['responses'] as Map<String, Object>).forEach((key, value) {
        responses.add(Response.fromKeyValue(key, value as Map<String, Object>));
      });
    }

    return Ressource(
      name: key,
      tag: tags[0] as String,
      operationId: operationId,
      summary: summary,
      responses: responses,
      // requests: requests,
    );
  }
}

@freezed
abstract class Response implements _$Response {
  const Response._();

  const factory Response({
    @required int code,
    String description,
    String ref,
  }) = _Response;

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
}

@freezed
abstract class Parameter implements _$Parameter {
  const Parameter._();

  const factory Parameter({
    @required String name,
    @required String ref,
    // 'in' value in OpenDate spec
    String origin,
    String description,
  }) = _Parameter;

  factory Parameter.fromJson(Map<String, Object> value) {
    final name = value['name'] as String;
    final description = value['description'] as String;
    final origin = value['in'] as String;
    final ref = (value['schema'] as Map<String, Object>)[r'$ref'] as String;

    return Parameter(
      name: name,
      description: description,
      origin: origin,
      ref: ref,
    );
  }
}
