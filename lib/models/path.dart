import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/json_parser.dart';
import '../utils/string_extensions.dart';

part 'path.freezed.dart';

@freezed
abstract class Path implements _$Path {
  const Path._();

  const factory Path({
    @required String iri,
    @required List<Ressource> ressources,
  }) = _Path;

  factory Path.fromKeyValue(String key, Map<String, Object> value) {
    return Path(
      iri: key,
      ressources: JsonParser.parseListOfMap<Ressource, Map<String, Object>>(
        value,
        (key, value) => Ressource.fromKeyValue(key, value),
      ),
    );
  }

  Ressource getRessourceByMethod(String method) {
    final _method = method.toLowerCase();

    if (!['get', 'post', 'put', 'delete'].contains(_method)) {
      throw Exception('Method $_method not available for path $iri');
    }

    return ressources.firstWhere(
      (ressource) => ressource.method == _method,
      orElse: () => throw ArgumentError(
        '${_method.toUpperCase()} method not found in specifications.',
      ),
    );
  }
}

@freezed
abstract class Ressource implements _$Ressource {
  const Ressource._();

  const factory Ressource({
    @required String method,
    @required String tag,
    @required String operationId,
    String summary,
    List<Response> responses,
    List<Parameter> parameters,
  }) = _Ressource;

  factory Ressource.fromKeyValue(String key, Map<String, Object> value) {
    return Ressource(
      method: key,
      tag: JsonParser.parseKey<List>(value, 'tags')[0] as String,
      operationId: JsonParser.parseKey<String>(value, 'operationId'),
      summary: JsonParser.parseKey<String>(value, 'summary'),
      responses: JsonParser.parseListOfMapByKey<Response, Map<String, Object>>(
        json: value,
        key: 'responses',
        builder: (key, value) => Response.fromKeyValue(key, value),
      ),
      parameters: value['parameters'] != null
          ? (value['parameters'] as Iterable)
              .map((dynamic e) => Parameter.fromJson(e as Map<String, Object>))
              .toList()
          : <Parameter>[],
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
    return Response(
      code: int.parse(key),
      description: JsonParser.parseKey<String>(value, 'description'),
      ref: JsonParser.parseSchema(value)?.allAfter('#/definitions/'),
    );
  }

  bool get hasDefinition => ref != null;
}

@freezed
abstract class Parameter implements _$Parameter {
  const Parameter._();

  const factory Parameter({
    @required String name,
    @required String ref,
    bool isRequired,
    // 'in' value in OpenDate spec
    String origin,
    String description,
  }) = _Parameter;

  factory Parameter.fromJson(Map<String, Object> json) {
    return Parameter(
      name: json['name'] as String,
      ref: JsonParser.parseSchema(json),
      isRequired: json['required'] != null,
      description: JsonParser.parseKey<String>(json, 'description'),
      origin: JsonParser.parseKey<String>(json, 'in'),
    );
  }
}
