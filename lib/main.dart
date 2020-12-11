import 'dart:io';

import 'package:riverpod/all.dart';

import 'models/path.dart';
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
  await container.read(specsProvider.future).catchError(
    (err) {
      stderr.writeln('error: $url is invalid');
      exit(2);
    },
  );

  /// get Path model.
  try {
    container.read(pathModelProvider);
  } catch (err) {
    stderr.writeln('error: $err');
    exit(2);
  }

  /// get definition reference for method (GET, PUT, POST).
  String ref;
  try {
    final responseModel = container.read(getResponseForPathAndMethod);
    ref = responseModel.ref;
  } catch (err) {
    stderr.writeln('error: $err');
    exit(2);
  }
  if (ref == null) {
    stderr.writeln('error: No definition found in specification');
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

// String _getDefinitionForGivenPathAndMethod(Path path) {
//   String ref;
//   try {
//     ref = path.getRessourceByMethod('get')?.responses?.first?.ref;
//   } catch (err) {
//     stderr.writeln('error: $err');
//     exit(2);
//   }
//   if (ref == null) {
//     stderr.writeln('error: No definition found in specification');
//     exit(2);
//   }

//   return ref;
// }
