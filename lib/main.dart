import 'dart:io';

import 'package:riverpod/all.dart';

import 'providers.dart';

Future<void> main(String url, String iri) async {
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
  final path = container.read(pathProvider(iri));

  /// get definition reference for GET method.
  final ref = path.getRessource.responses.first.ref;

  /// get Definition model.
  final def = container.read(definitionProvider(ref));

  /// write file(s).
  await container.read(writeToFile(def).future);

  return;
}
