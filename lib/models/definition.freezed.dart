// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'definition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$DefinitionTearOff {
  const _$DefinitionTearOff();

// ignore: unused_element
  _Definition call(
      {@required String name,
      String description,
      List<Property> properties,
      List<String> requiredProperties}) {
    return _Definition(
      name: name,
      description: description,
      properties: properties,
      requiredProperties: requiredProperties,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $Definition = _$DefinitionTearOff();

/// @nodoc
mixin _$Definition {
  String get name;
  String get description;
  List<Property> get properties;
  List<String> get requiredProperties;

  $DefinitionCopyWith<Definition> get copyWith;
}

/// @nodoc
abstract class $DefinitionCopyWith<$Res> {
  factory $DefinitionCopyWith(
          Definition value, $Res Function(Definition) then) =
      _$DefinitionCopyWithImpl<$Res>;
  $Res call(
      {String name,
      String description,
      List<Property> properties,
      List<String> requiredProperties});
}

/// @nodoc
class _$DefinitionCopyWithImpl<$Res> implements $DefinitionCopyWith<$Res> {
  _$DefinitionCopyWithImpl(this._value, this._then);

  final Definition _value;
  // ignore: unused_field
  final $Res Function(Definition) _then;

  @override
  $Res call({
    Object name = freezed,
    Object description = freezed,
    Object properties = freezed,
    Object requiredProperties = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed ? _value.name : name as String,
      description:
          description == freezed ? _value.description : description as String,
      properties: properties == freezed
          ? _value.properties
          : properties as List<Property>,
      requiredProperties: requiredProperties == freezed
          ? _value.requiredProperties
          : requiredProperties as List<String>,
    ));
  }
}

/// @nodoc
abstract class _$DefinitionCopyWith<$Res> implements $DefinitionCopyWith<$Res> {
  factory _$DefinitionCopyWith(
          _Definition value, $Res Function(_Definition) then) =
      __$DefinitionCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      String description,
      List<Property> properties,
      List<String> requiredProperties});
}

/// @nodoc
class __$DefinitionCopyWithImpl<$Res> extends _$DefinitionCopyWithImpl<$Res>
    implements _$DefinitionCopyWith<$Res> {
  __$DefinitionCopyWithImpl(
      _Definition _value, $Res Function(_Definition) _then)
      : super(_value, (v) => _then(v as _Definition));

  @override
  _Definition get _value => super._value as _Definition;

  @override
  $Res call({
    Object name = freezed,
    Object description = freezed,
    Object properties = freezed,
    Object requiredProperties = freezed,
  }) {
    return _then(_Definition(
      name: name == freezed ? _value.name : name as String,
      description:
          description == freezed ? _value.description : description as String,
      properties: properties == freezed
          ? _value.properties
          : properties as List<Property>,
      requiredProperties: requiredProperties == freezed
          ? _value.requiredProperties
          : requiredProperties as List<String>,
    ));
  }
}

/// @nodoc
class _$_Definition extends _Definition {
  _$_Definition(
      {@required this.name,
      this.description,
      this.properties,
      this.requiredProperties})
      : assert(name != null),
        super._();

  @override
  final String name;
  @override
  final String description;
  @override
  final List<Property> properties;
  @override
  final List<String> requiredProperties;

  @override
  String toString() {
    return 'Definition(name: $name, description: $description, properties: $properties, requiredProperties: $requiredProperties)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Definition &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.properties, properties) ||
                const DeepCollectionEquality()
                    .equals(other.properties, properties)) &&
            (identical(other.requiredProperties, requiredProperties) ||
                const DeepCollectionEquality()
                    .equals(other.requiredProperties, requiredProperties)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(properties) ^
      const DeepCollectionEquality().hash(requiredProperties);

  @override
  _$DefinitionCopyWith<_Definition> get copyWith =>
      __$DefinitionCopyWithImpl<_Definition>(this, _$identity);
}

abstract class _Definition extends Definition {
  _Definition._() : super._();
  factory _Definition(
      {@required String name,
      String description,
      List<Property> properties,
      List<String> requiredProperties}) = _$_Definition;

  @override
  String get name;
  @override
  String get description;
  @override
  List<Property> get properties;
  @override
  List<String> get requiredProperties;
  @override
  _$DefinitionCopyWith<_Definition> get copyWith;
}

/// @nodoc
class _$PropertyTearOff {
  const _$PropertyTearOff();

// ignore: unused_element
  _Property call(
      {@required String name,
      @required Type type,
      Type subType,
      String ref,
      String description}) {
    return _Property(
      name: name,
      type: type,
      subType: subType,
      ref: ref,
      description: description,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $Property = _$PropertyTearOff();

/// @nodoc
mixin _$Property {
  String get name;
  Type get type;
  Type get subType;
  String get ref;
  String get description;

  $PropertyCopyWith<Property> get copyWith;
}

/// @nodoc
abstract class $PropertyCopyWith<$Res> {
  factory $PropertyCopyWith(Property value, $Res Function(Property) then) =
      _$PropertyCopyWithImpl<$Res>;
  $Res call(
      {String name, Type type, Type subType, String ref, String description});
}

/// @nodoc
class _$PropertyCopyWithImpl<$Res> implements $PropertyCopyWith<$Res> {
  _$PropertyCopyWithImpl(this._value, this._then);

  final Property _value;
  // ignore: unused_field
  final $Res Function(Property) _then;

  @override
  $Res call({
    Object name = freezed,
    Object type = freezed,
    Object subType = freezed,
    Object ref = freezed,
    Object description = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed ? _value.name : name as String,
      type: type == freezed ? _value.type : type as Type,
      subType: subType == freezed ? _value.subType : subType as Type,
      ref: ref == freezed ? _value.ref : ref as String,
      description:
          description == freezed ? _value.description : description as String,
    ));
  }
}

/// @nodoc
abstract class _$PropertyCopyWith<$Res> implements $PropertyCopyWith<$Res> {
  factory _$PropertyCopyWith(_Property value, $Res Function(_Property) then) =
      __$PropertyCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name, Type type, Type subType, String ref, String description});
}

/// @nodoc
class __$PropertyCopyWithImpl<$Res> extends _$PropertyCopyWithImpl<$Res>
    implements _$PropertyCopyWith<$Res> {
  __$PropertyCopyWithImpl(_Property _value, $Res Function(_Property) _then)
      : super(_value, (v) => _then(v as _Property));

  @override
  _Property get _value => super._value as _Property;

  @override
  $Res call({
    Object name = freezed,
    Object type = freezed,
    Object subType = freezed,
    Object ref = freezed,
    Object description = freezed,
  }) {
    return _then(_Property(
      name: name == freezed ? _value.name : name as String,
      type: type == freezed ? _value.type : type as Type,
      subType: subType == freezed ? _value.subType : subType as Type,
      ref: ref == freezed ? _value.ref : ref as String,
      description:
          description == freezed ? _value.description : description as String,
    ));
  }
}

/// @nodoc
class _$_Property extends _Property {
  const _$_Property(
      {@required this.name,
      @required this.type,
      this.subType,
      this.ref,
      this.description})
      : assert(name != null),
        assert(type != null),
        super._();

  @override
  final String name;
  @override
  final Type type;
  @override
  final Type subType;
  @override
  final String ref;
  @override
  final String description;

  @override
  String toString() {
    return 'Property(name: $name, type: $type, subType: $subType, ref: $ref, description: $description)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Property &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.subType, subType) ||
                const DeepCollectionEquality()
                    .equals(other.subType, subType)) &&
            (identical(other.ref, ref) ||
                const DeepCollectionEquality().equals(other.ref, ref)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(subType) ^
      const DeepCollectionEquality().hash(ref) ^
      const DeepCollectionEquality().hash(description);

  @override
  _$PropertyCopyWith<_Property> get copyWith =>
      __$PropertyCopyWithImpl<_Property>(this, _$identity);
}

abstract class _Property extends Property {
  const _Property._() : super._();
  const factory _Property(
      {@required String name,
      @required Type type,
      Type subType,
      String ref,
      String description}) = _$_Property;

  @override
  String get name;
  @override
  Type get type;
  @override
  Type get subType;
  @override
  String get ref;
  @override
  String get description;
  @override
  _$PropertyCopyWith<_Property> get copyWith;
}
