import 'dart:io';

import 'package:riverpod/all.dart';

import 'output/file_manager.dart';
import 'providers.dart';

Future<void> main(String url, String path) async {
  final container = ProviderContainer(
    overrides: [urlProvider.overrideWithValue(url)],
  );

  /// load open api documentation.
  await container.read(specsProvider.future).catchError(
    (err) {
      stderr.writeln('error: $url is invalid');
      exit(2);
    },
  );

  /// get Path model.
  final pathModel = container.read(pathProvider(path));
  if (pathModel == null) {
    stderr.writeln('error: undefine $path in specifications');
    exit(2);
  }

  /// get definition reference for GET method.
  final ref = pathModel?.getRessource?.responses?.first?.ref;
  if (ref == null) {
    stderr.writeln('error: no GET method found in specifications');
    exit(2);
  }

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
