import 'dart:io';

import 'package:riverpod/all.dart';

import 'models/path.dart';
import 'output/file_manager.dart';
import 'providers.dart';

Future<void> main(String url, String path) async {
  final container = ProviderContainer(
    overrides: [
      urlProvider.overrideWithValue(url),
      pathProvider.overrideWithValue(path),
    ],
  );

  /// load open api documentation.
  await container.read(specsProvider.future).catchError(
    (err) {
      stderr.writeln('error: $url is invalid');
      exit(2);
    },
  );

  /// get Path model.
  final pathModel = container.read(pathModelProvider);
  if (pathModel == null) {
    stderr.writeln('error: undefine $path in specifications');
    exit(2);
  }

  /// get definition reference for method (GET, PUT, POST, DELETE).
  final ref = _getDefinitionForGivenPathAndMethod(pathModel);

  /// get Definition model.
  final def = container.read(definitionProvider(ref));

  /// write file(s).
  await container.read(writeToFile(def).future);

  /// create main file with parts of.
  final stringBuffer = container.read(stringBufferProvider);
  final fileName = container.read(mainFileNameProvider);
  await FileManager(container.read, stringBuffer: stringBuffer).save(fileName);

  return;
}

String _getDefinitionForGivenPathAndMethod(Path path) {
  String ref;
  try {
    ref = path.getRessourceByMethod('get')?.responses?.first?.ref;
  } catch (err) {
    stderr.writeln('error: $err');
    exit(2);
  }
  if (ref == null) {
    stderr.writeln('error: No definition found in specification');
    exit(2);
  }

  return ref;
}
