import 'package:freezed_annotation/freezed_annotation.dart';

part 'reference.freezed.dart';

@freezed
abstract class Reference with _$Reference {
  const Reference._();
  const factory Reference({
    @required String value,
    @required String description,
  }) = _Reference;
}
