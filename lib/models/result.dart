import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
abstract class Result<T> with _$Result<T> {
  const Result._();
  const factory Result.data(@nullable T value) = _ResultData<T>;
  const factory Result.error(dynamic error) = _ResultError<T>;

  // Retrun either data or error from Future.
  static Future<Result<T>> guardFuture<T>(Future<T> Function() future) async {
    try {
      return Result.data(await future());
    } catch (error) {
      return Result.error(error);
    }
  }

  T get dataOrThrow {
    return when(
      data: (value) => value,
      error: (dynamic err) {
        throw err;
      },
    );
  }

  void onError(void Function(dynamic error) cb) {
    when(
      data: (_) {},
      error: (dynamic err) => cb(err),
    );
  }
}
