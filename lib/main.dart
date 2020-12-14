import 'dart:io';

import 'package:meta/meta.dart';
import 'package:riverpod/all.dart';

import 'output/dart_class_printer.dart';
import 'output/file_manager.dart';
import 'providers.dart';
import 'utils/string_extensions.dart';

Future<void> main({
  @required String methods,
  @required String dir,
  String file,
  String url,
  String path,
  bool freezed = false,
  String header,
}) async {
  final headerAsMap = _parseHeader(header);

  final container = ProviderContainer(
    overrides: [
      fileProvider.overrideWithValue(file),
      urlProvider.overrideWithValue(url),
      directoryProvider.overrideWithValue(dir),
      httpHeaderProvider.overrideWithValue(headerAsMap),
      pathProvider.overrideWithValue(path),
      methodProvider.overrideWithValue(methods.toLowerCase()),
      isFreezedClass.overrideWithValue(freezed),
    ],
  );

  /// load open api documentation.
  await container.read(specsProvider.future).catchError((dynamic _) {
    stderr.writeln('error: ${url ?? file} argument is invalid');
    exit(2);
  });

  /// get Path model.
  container.read(pathModelProvider).onError(_handleError);

  await _writeResponses(container);

  exit(0);
}

Future<void> _writeResponses(ProviderContainer container) async {
  final directory = _getDirectory(container);

  /// Find [Ressource]  for given path.
  final result = container.read(getRessourcesForPath)..onError(_handleError);
  final ressource = result.dataOrThrow;
  final responses =
      ressource.responses.where((response) => response.hasDefinition).toList();

  for (final response in responses) {
    /// write file(s).
    try {
      await DartClassPrinter(
        container.read,
        ref: response.ref,
        directory: directory,
        className: response.description.withoutBlankCharacters,
      ).generate();
    } catch (err) {
      _handleError(err);
    }

    await _saveImportsFile(container, directory);
  }
}

/// Get path name for given ressource method.
String _getDirectory(ProviderContainer container) {
  final dir = container.read(directoryProvider);
  // var path = container.read(pathProvider);
  // path.contains('/{id}')
  //     ? path = path.replaceAll(RegExp(r'/{id}'), '_item')
  //     : path = '${path}_collection';
  return '$dir';
}

/// Save main file with `part of '..` list.
Future<void> _saveImportsFile(ProviderContainer container, String dir) async {
  final stringBuffer = container.read(stringBufferProvider);
  final fileName = container.read(mainResponseFileNameProvider);

  // Write and save file.
  await FileManager(
    container.read,
    dir,
    stringBuffer: stringBuffer,
  ).save(fileName);

  // Cleanup string buffer
  container.refresh(stringBufferProvider);
}

Map<String, String> _parseHeader(String input) {
  if (input == null) return null;

  try {
    if (!RegExp(r'^\w+:[\w|\s]+$').hasMatch(input)) throw ArgumentError();
    final matches = input.split(':');
    return {matches[0]: matches[1]};
  } catch (_) {
    stdout.writeln('Invalid argument, skipping header.');
    return null;
  }
}

void _handleError(dynamic error) {
  stderr.writeln('$error');
  exit(2);
}
