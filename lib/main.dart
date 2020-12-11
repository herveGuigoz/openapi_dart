import 'dart:io';

import 'package:riverpod/all.dart';

import 'output/file_manager.dart';
import 'providers.dart';

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
  container.read(pathModelProvider).onError((dynamic err) {
    stderr.writeln('$err');
    exit(2);
  });

  /// get definition reference for method (GET, POST, PUT).
  final result = container.read(getResponseForPathAndMethod)
    ..onError((dynamic err) {
      stderr.writeln('$err');
      exit(2);
    });

  /// get Definition model.
  final def = container.read(definitionProvider(result.dataOrThrow.value));
  if (def == null) {
    stderr.writeln('Definition not found');
    exit(2);
  }

  /// write file(s).
  await container.read(writeToFile(def).future).catchError((dynamic err) {
    stderr.writeln('$err');
    exit(2);
  });

  /// create main file with parts of.
  final stringBuffer = container.read(stringBufferProvider);
  final fileName = container.read(mainFileNameProvider);
  await FileManager(container.read, stringBuffer: stringBuffer).save(fileName);

  exit(0);
}
