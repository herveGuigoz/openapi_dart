import 'dart:io';

import 'package:swagger_to_dart_response_model/models/definition.dart';
import 'package:swagger_to_dart_response_model/providers.dart';
import 'package:riverpod/all.dart';
import 'package:test/test.dart';

void main() async {
  final file = File('test/swagger.json');
  final json = await file.readAsString();

  test('parse definitions', () async {
    final container = ProviderContainer(
      overrides: [specsProvider.overrideWithValue(AsyncData(json))],
    );
    final definitions = container.read(definitionsProvider);
    expect(definitions.length, 6);
    expect(definitions.byName('ApiResponse').properties.length, 3);
    expect(definitions.byName('Category').properties.length, 2);
    expect(definitions.byName('Pet').properties.length, 6);
    expect(definitions.byName('Pet').requiredProperties.length, 2);
    expect(definitions.byName('Tag').properties.length, 2);
    expect(definitions.byName('Order').properties.length, 6);
    expect(definitions.byName('User').properties.length, 8);
    expect(definitions.byName(''), null);
  });

  // test('parse paths', () async {
  //   final container = ProviderContainer(
  //     overrides: [specsProvider.overrideWithValue(AsyncData(json))],
  //   );
  //   final paths = container.read(pathsProvider);

  //   for (final path in paths) {
  //     print(path.iri);
  //   }

  //   expect(paths.length, 14);
  // });
}
