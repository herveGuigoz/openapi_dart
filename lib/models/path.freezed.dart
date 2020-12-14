// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'path.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$PathTearOff {
  const _$PathTearOff();

// ignore: unused_element
  _Path call({@required String iri, @required List<Ressource> ressources}) {
    return _Path(
      iri: iri,
      ressources: ressources,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $Path = _$PathTearOff();

/// @nodoc
mixin _$Path {
  String get iri;
  List<Ressource> get ressources;

  $PathCopyWith<Path> get copyWith;
}

/// @nodoc
abstract class $PathCopyWith<$Res> {
  factory $PathCopyWith(Path value, $Res Function(Path) then) =
      _$PathCopyWithImpl<$Res>;
  $Res call({String iri, List<Ressource> ressources});
}

/// @nodoc
class _$PathCopyWithImpl<$Res> implements $PathCopyWith<$Res> {
  _$PathCopyWithImpl(this._value, this._then);

  final Path _value;
  // ignore: unused_field
  final $Res Function(Path) _then;

  @override
  $Res call({
    Object iri = freezed,
    Object ressources = freezed,
  }) {
    return _then(_value.copyWith(
      iri: iri == freezed ? _value.iri : iri as String,
      ressources: ressources == freezed
          ? _value.ressources
          : ressources as List<Ressource>,
    ));
  }
}

/// @nodoc
abstract class _$PathCopyWith<$Res> implements $PathCopyWith<$Res> {
  factory _$PathCopyWith(_Path value, $Res Function(_Path) then) =
      __$PathCopyWithImpl<$Res>;
  @override
  $Res call({String iri, List<Ressource> ressources});
}

/// @nodoc
class __$PathCopyWithImpl<$Res> extends _$PathCopyWithImpl<$Res>
    implements _$PathCopyWith<$Res> {
  __$PathCopyWithImpl(_Path _value, $Res Function(_Path) _then)
      : super(_value, (v) => _then(v as _Path));

  @override
  _Path get _value => super._value as _Path;

  @override
  $Res call({
    Object iri = freezed,
    Object ressources = freezed,
  }) {
    return _then(_Path(
      iri: iri == freezed ? _value.iri : iri as String,
      ressources: ressources == freezed
          ? _value.ressources
          : ressources as List<Ressource>,
    ));
  }
}

/// @nodoc
class _$_Path extends _Path {
  const _$_Path({@required this.iri, @required this.ressources})
      : assert(iri != null),
        assert(ressources != null),
        super._();

  @override
  final String iri;
  @override
  final List<Ressource> ressources;

  @override
  String toString() {
    return 'Path(iri: $iri, ressources: $ressources)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Path &&
            (identical(other.iri, iri) ||
                const DeepCollectionEquality().equals(other.iri, iri)) &&
            (identical(other.ressources, ressources) ||
                const DeepCollectionEquality()
                    .equals(other.ressources, ressources)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(iri) ^
      const DeepCollectionEquality().hash(ressources);

  @override
  _$PathCopyWith<_Path> get copyWith =>
      __$PathCopyWithImpl<_Path>(this, _$identity);
}

abstract class _Path extends Path {
  const _Path._() : super._();
  const factory _Path(
      {@required String iri, @required List<Ressource> ressources}) = _$_Path;

  @override
  String get iri;
  @override
  List<Ressource> get ressources;
  @override
  _$PathCopyWith<_Path> get copyWith;
}

/// @nodoc
class _$RessourceTearOff {
  const _$RessourceTearOff();

// ignore: unused_element
  _Ressource call(
      {@required String method,
      @required String tag,
      @required String operationId,
      String summary,
      List<Response> responses,
      List<Parameter> parameters}) {
    return _Ressource(
      method: method,
      tag: tag,
      operationId: operationId,
      summary: summary,
      responses: responses,
      parameters: parameters,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $Ressource = _$RessourceTearOff();

/// @nodoc
mixin _$Ressource {
  String get method;
  String get tag;
  String get operationId;
  String get summary;
  List<Response> get responses;
  List<Parameter> get parameters;

  $RessourceCopyWith<Ressource> get copyWith;
}

/// @nodoc
abstract class $RessourceCopyWith<$Res> {
  factory $RessourceCopyWith(Ressource value, $Res Function(Ressource) then) =
      _$RessourceCopyWithImpl<$Res>;
  $Res call(
      {String method,
      String tag,
      String operationId,
      String summary,
      List<Response> responses,
      List<Parameter> parameters});
}

/// @nodoc
class _$RessourceCopyWithImpl<$Res> implements $RessourceCopyWith<$Res> {
  _$RessourceCopyWithImpl(this._value, this._then);

  final Ressource _value;
  // ignore: unused_field
  final $Res Function(Ressource) _then;

  @override
  $Res call({
    Object method = freezed,
    Object tag = freezed,
    Object operationId = freezed,
    Object summary = freezed,
    Object responses = freezed,
    Object parameters = freezed,
  }) {
    return _then(_value.copyWith(
      method: method == freezed ? _value.method : method as String,
      tag: tag == freezed ? _value.tag : tag as String,
      operationId:
          operationId == freezed ? _value.operationId : operationId as String,
      summary: summary == freezed ? _value.summary : summary as String,
      responses:
          responses == freezed ? _value.responses : responses as List<Response>,
      parameters: parameters == freezed
          ? _value.parameters
          : parameters as List<Parameter>,
    ));
  }
}

/// @nodoc
abstract class _$RessourceCopyWith<$Res> implements $RessourceCopyWith<$Res> {
  factory _$RessourceCopyWith(
          _Ressource value, $Res Function(_Ressource) then) =
      __$RessourceCopyWithImpl<$Res>;
  @override
  $Res call(
      {String method,
      String tag,
      String operationId,
      String summary,
      List<Response> responses,
      List<Parameter> parameters});
}

/// @nodoc
class __$RessourceCopyWithImpl<$Res> extends _$RessourceCopyWithImpl<$Res>
    implements _$RessourceCopyWith<$Res> {
  __$RessourceCopyWithImpl(_Ressource _value, $Res Function(_Ressource) _then)
      : super(_value, (v) => _then(v as _Ressource));

  @override
  _Ressource get _value => super._value as _Ressource;

  @override
  $Res call({
    Object method = freezed,
    Object tag = freezed,
    Object operationId = freezed,
    Object summary = freezed,
    Object responses = freezed,
    Object parameters = freezed,
  }) {
    return _then(_Ressource(
      method: method == freezed ? _value.method : method as String,
      tag: tag == freezed ? _value.tag : tag as String,
      operationId:
          operationId == freezed ? _value.operationId : operationId as String,
      summary: summary == freezed ? _value.summary : summary as String,
      responses:
          responses == freezed ? _value.responses : responses as List<Response>,
      parameters: parameters == freezed
          ? _value.parameters
          : parameters as List<Parameter>,
    ));
  }
}

/// @nodoc
class _$_Ressource extends _Ressource {
  const _$_Ressource(
      {@required this.method,
      @required this.tag,
      @required this.operationId,
      this.summary,
      this.responses,
      this.parameters})
      : assert(method != null),
        assert(tag != null),
        assert(operationId != null),
        super._();

  @override
  final String method;
  @override
  final String tag;
  @override
  final String operationId;
  @override
  final String summary;
  @override
  final List<Response> responses;
  @override
  final List<Parameter> parameters;

  @override
  String toString() {
    return 'Ressource(method: $method, tag: $tag, operationId: $operationId, summary: $summary, responses: $responses, parameters: $parameters)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Ressource &&
            (identical(other.method, method) ||
                const DeepCollectionEquality().equals(other.method, method)) &&
            (identical(other.tag, tag) ||
                const DeepCollectionEquality().equals(other.tag, tag)) &&
            (identical(other.operationId, operationId) ||
                const DeepCollectionEquality()
                    .equals(other.operationId, operationId)) &&
            (identical(other.summary, summary) ||
                const DeepCollectionEquality()
                    .equals(other.summary, summary)) &&
            (identical(other.responses, responses) ||
                const DeepCollectionEquality()
                    .equals(other.responses, responses)) &&
            (identical(other.parameters, parameters) ||
                const DeepCollectionEquality()
                    .equals(other.parameters, parameters)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(method) ^
      const DeepCollectionEquality().hash(tag) ^
      const DeepCollectionEquality().hash(operationId) ^
      const DeepCollectionEquality().hash(summary) ^
      const DeepCollectionEquality().hash(responses) ^
      const DeepCollectionEquality().hash(parameters);

  @override
  _$RessourceCopyWith<_Ressource> get copyWith =>
      __$RessourceCopyWithImpl<_Ressource>(this, _$identity);
}

abstract class _Ressource extends Ressource {
  const _Ressource._() : super._();
  const factory _Ressource(
      {@required String method,
      @required String tag,
      @required String operationId,
      String summary,
      List<Response> responses,
      List<Parameter> parameters}) = _$_Ressource;

  @override
  String get method;
  @override
  String get tag;
  @override
  String get operationId;
  @override
  String get summary;
  @override
  List<Response> get responses;
  @override
  List<Parameter> get parameters;
  @override
  _$RessourceCopyWith<_Ressource> get copyWith;
}

/// @nodoc
class _$ResponseTearOff {
  const _$ResponseTearOff();

// ignore: unused_element
  _Response call({@required int code, String description, String ref}) {
    return _Response(
      code: code,
      description: description,
      ref: ref,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $Response = _$ResponseTearOff();

/// @nodoc
mixin _$Response {
  int get code;
  String get description;
  String get ref;

  $ResponseCopyWith<Response> get copyWith;
}

/// @nodoc
abstract class $ResponseCopyWith<$Res> {
  factory $ResponseCopyWith(Response value, $Res Function(Response) then) =
      _$ResponseCopyWithImpl<$Res>;
  $Res call({int code, String description, String ref});
}

/// @nodoc
class _$ResponseCopyWithImpl<$Res> implements $ResponseCopyWith<$Res> {
  _$ResponseCopyWithImpl(this._value, this._then);

  final Response _value;
  // ignore: unused_field
  final $Res Function(Response) _then;

  @override
  $Res call({
    Object code = freezed,
    Object description = freezed,
    Object ref = freezed,
  }) {
    return _then(_value.copyWith(
      code: code == freezed ? _value.code : code as int,
      description:
          description == freezed ? _value.description : description as String,
      ref: ref == freezed ? _value.ref : ref as String,
    ));
  }
}

/// @nodoc
abstract class _$ResponseCopyWith<$Res> implements $ResponseCopyWith<$Res> {
  factory _$ResponseCopyWith(_Response value, $Res Function(_Response) then) =
      __$ResponseCopyWithImpl<$Res>;
  @override
  $Res call({int code, String description, String ref});
}

/// @nodoc
class __$ResponseCopyWithImpl<$Res> extends _$ResponseCopyWithImpl<$Res>
    implements _$ResponseCopyWith<$Res> {
  __$ResponseCopyWithImpl(_Response _value, $Res Function(_Response) _then)
      : super(_value, (v) => _then(v as _Response));

  @override
  _Response get _value => super._value as _Response;

  @override
  $Res call({
    Object code = freezed,
    Object description = freezed,
    Object ref = freezed,
  }) {
    return _then(_Response(
      code: code == freezed ? _value.code : code as int,
      description:
          description == freezed ? _value.description : description as String,
      ref: ref == freezed ? _value.ref : ref as String,
    ));
  }
}

/// @nodoc
class _$_Response extends _Response {
  const _$_Response({@required this.code, this.description, this.ref})
      : assert(code != null),
        super._();

  @override
  final int code;
  @override
  final String description;
  @override
  final String ref;

  @override
  String toString() {
    return 'Response(code: $code, description: $description, ref: $ref)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Response &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.ref, ref) ||
                const DeepCollectionEquality().equals(other.ref, ref)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(code) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(ref);

  @override
  _$ResponseCopyWith<_Response> get copyWith =>
      __$ResponseCopyWithImpl<_Response>(this, _$identity);
}

abstract class _Response extends Response {
  const _Response._() : super._();
  const factory _Response(
      {@required int code, String description, String ref}) = _$_Response;

  @override
  int get code;
  @override
  String get description;
  @override
  String get ref;
  @override
  _$ResponseCopyWith<_Response> get copyWith;
}

/// @nodoc
class _$ParameterTearOff {
  const _$ParameterTearOff();

// ignore: unused_element
  _Parameter call(
      {@required String name,
      @required String ref,
      bool isRequired,
      String origin,
      String description}) {
    return _Parameter(
      name: name,
      ref: ref,
      isRequired: isRequired,
      origin: origin,
      description: description,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $Parameter = _$ParameterTearOff();

/// @nodoc
mixin _$Parameter {
  String get name;
  String get ref;
  bool get isRequired; // 'in' value in OpenDate spec
  String get origin;
  String get description;

  $ParameterCopyWith<Parameter> get copyWith;
}

/// @nodoc
abstract class $ParameterCopyWith<$Res> {
  factory $ParameterCopyWith(Parameter value, $Res Function(Parameter) then) =
      _$ParameterCopyWithImpl<$Res>;
  $Res call(
      {String name,
      String ref,
      bool isRequired,
      String origin,
      String description});
}

/// @nodoc
class _$ParameterCopyWithImpl<$Res> implements $ParameterCopyWith<$Res> {
  _$ParameterCopyWithImpl(this._value, this._then);

  final Parameter _value;
  // ignore: unused_field
  final $Res Function(Parameter) _then;

  @override
  $Res call({
    Object name = freezed,
    Object ref = freezed,
    Object isRequired = freezed,
    Object origin = freezed,
    Object description = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed ? _value.name : name as String,
      ref: ref == freezed ? _value.ref : ref as String,
      isRequired:
          isRequired == freezed ? _value.isRequired : isRequired as bool,
      origin: origin == freezed ? _value.origin : origin as String,
      description:
          description == freezed ? _value.description : description as String,
    ));
  }
}

/// @nodoc
abstract class _$ParameterCopyWith<$Res> implements $ParameterCopyWith<$Res> {
  factory _$ParameterCopyWith(
          _Parameter value, $Res Function(_Parameter) then) =
      __$ParameterCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      String ref,
      bool isRequired,
      String origin,
      String description});
}

/// @nodoc
class __$ParameterCopyWithImpl<$Res> extends _$ParameterCopyWithImpl<$Res>
    implements _$ParameterCopyWith<$Res> {
  __$ParameterCopyWithImpl(_Parameter _value, $Res Function(_Parameter) _then)
      : super(_value, (v) => _then(v as _Parameter));

  @override
  _Parameter get _value => super._value as _Parameter;

  @override
  $Res call({
    Object name = freezed,
    Object ref = freezed,
    Object isRequired = freezed,
    Object origin = freezed,
    Object description = freezed,
  }) {
    return _then(_Parameter(
      name: name == freezed ? _value.name : name as String,
      ref: ref == freezed ? _value.ref : ref as String,
      isRequired:
          isRequired == freezed ? _value.isRequired : isRequired as bool,
      origin: origin == freezed ? _value.origin : origin as String,
      description:
          description == freezed ? _value.description : description as String,
    ));
  }
}

/// @nodoc
class _$_Parameter extends _Parameter {
  const _$_Parameter(
      {@required this.name,
      @required this.ref,
      this.isRequired,
      this.origin,
      this.description})
      : assert(name != null),
        assert(ref != null),
        super._();

  @override
  final String name;
  @override
  final String ref;
  @override
  final bool isRequired;
  @override // 'in' value in OpenDate spec
  final String origin;
  @override
  final String description;

  @override
  String toString() {
    return 'Parameter(name: $name, ref: $ref, isRequired: $isRequired, origin: $origin, description: $description)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Parameter &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.ref, ref) ||
                const DeepCollectionEquality().equals(other.ref, ref)) &&
            (identical(other.isRequired, isRequired) ||
                const DeepCollectionEquality()
                    .equals(other.isRequired, isRequired)) &&
            (identical(other.origin, origin) ||
                const DeepCollectionEquality().equals(other.origin, origin)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(ref) ^
      const DeepCollectionEquality().hash(isRequired) ^
      const DeepCollectionEquality().hash(origin) ^
      const DeepCollectionEquality().hash(description);

  @override
  _$ParameterCopyWith<_Parameter> get copyWith =>
      __$ParameterCopyWithImpl<_Parameter>(this, _$identity);
}

abstract class _Parameter extends Parameter {
  const _Parameter._() : super._();
  const factory _Parameter(
      {@required String name,
      @required String ref,
      bool isRequired,
      String origin,
      String description}) = _$_Parameter;

  @override
  String get name;
  @override
  String get ref;
  @override
  bool get isRequired;
  @override // 'in' value in OpenDate spec
  String get origin;
  @override
  String get description;
  @override
  _$ParameterCopyWith<_Parameter> get copyWith;
}
