import 'dart:io';

import 'package:riverpod/all.dart';

import 'output/dart_class_printer.dart';
import 'output/file_manager.dart';
import 'providers.dart';
import 'utils/string_extensions.dart';

Future<void> main(String url, String path, String method) async {
  final container = ProviderContainer(
    overrides: [
      urlProvider.overrideWithValue(url),
      pathProvider.overrideWithValue(path),
      methodProvider.overrideWithValue(method),
    ],
  );

  /// load open api documentation.
  await container.read(specsProvider.future).catchError((dynamic _) {
    stderr.writeln('error: $url is invalid');
    exit(2);
  });

  /// get Path model.
  container.read(pathModelProvider).onError(_handleError);

  await _writeResponses(container);

  exit(0);
}

Future<void> _writeResponses(ProviderContainer container) async {
  /// Find [Ressource] list for given path.
  final result = container.read(getRessourcesForPath)..onError(_handleError);

  /// Find [Response] for method GET
  final response = result.dataOrThrow.first.responses.first;

  /// write file(s).
  try {
    await DartClassPrinter(
      container.read,
      ref: response.ref,
      className: response.description.withoutBlankCharacters,
    ).generate();
  } catch (err) {
    _handleError(err);
  }

  await _saveImportsFile(container);
}

/// Save main file with `part of '..` list.
Future<void> _saveImportsFile(ProviderContainer container) async {
  final stringBuffer = container.read(stringBufferProvider);
  final fileName = container.read(mainResponseFileNameProvider);
  await FileManager(container.read, stringBuffer: stringBuffer).save(fileName);
}

void _handleError(dynamic error) {
  stderr.writeln('$error');
  exit(2);
}
