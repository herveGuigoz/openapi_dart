import 'dart:convert';
import 'dart:io';

import 'package:openapi_dart/models/result.dart';
import 'package:openapi_dart/utils/json_parser.dart';
import 'package:riverpod/all.dart';

import 'models/definition.dart';
import 'models/path.dart';
import 'network/repository.dart';

/// OpenApi documentation url.
final urlProvider = Provider<String>(null);

/// User path to request as String
final pathProvider = Provider<String>(null);

final methodProvider = Provider<String>(null);

/// Output directory for generated files.
final dirPathProvider = Provider((_) => 'build/');

/// Parent file name where all `Part '...';` will be injected.
final mainResponseFileNameProvider = Provider<String>((ref) {
  return 'responses.dart';
});

/// Network call to load openApi documetation.
final specsProvider = FutureProvider<String>((ref) async {
  final url = ref.read(urlProvider);
  stdout.writeln('Loading spec from $url..');
  return Repository.loadJson(url);
});

/// All Definition list in openApi documentation.
final definitionsProvider = Provider<List<Definition>>((ref) {
  List<Definition> defs;
  ref.read(specsProvider).whenData((value) {
    final map = json.decode(value) as Map<String, Object>;
    defs = JsonParser.parseListOfMapByKey<Definition, Map<String, Object>>(
      json: map,
      key: 'definitions',
      builder: (key, value) => Definition.fromKeyValue(key, value),
    );
  });

  return defs ?? <Definition>[];
});

/// Find given Definition in openApi documentation.
final definitionProvider = Provider.family<Definition, String>((ref, param) {
  return ref.read(definitionsProvider).firstWhere((def) => def.name == param);
});

/// All Paths list in openApi documentation.
final pathsProvider = Provider<List<Path>>((ref) {
  final paths = <Path>[];
  ref.read(specsProvider).whenData((value) {
    final map = json.decode(value) as Map<String, Object>;
    (map['paths'] as Map<String, Object>).forEach((key, value) {
      paths.add(
        Path.fromKeyValue(key, value as Map<String, Object>),
      );
    });
  });
  return paths;
});

/// Find given Path in openApi documentation.
final pathModelProvider = Provider<Result<Path>>((ref) {
  final param = ref.read(pathProvider);
  final path = ref.read(pathsProvider).firstWhere(
        (path) => path.iri == param,
        orElse: () => null,
      );

  return path != null
      ? Result.data(path)
      : Result.error(ArgumentError('undefine $param in specifications'));
});

/// Get reference for response definition
final getRessourcesForPath = Provider<Result<List<Ressource>>>((ref) {
  List<Ressource> ressources;
  try {
    final path = ref.read(pathModelProvider).dataOrThrow;
    ressources = path.ressources;
  } catch (err) {
    return Result.error(err.toString());
  }

  return Result.data(ressources ?? <Ressource>[]);
});

/// Where all `part '...';` will be saved.
final stringBufferProvider = Provider(
  (_) => StringBuffer()..writeln("import 'package:meta/meta.dart';\n"),
);

// final filesControllerProvider = Provider<StateController<List<String>>>(
//   (ref) => StateController<List<String>>(<String>[]),
// );

// final fileAlreadyCreated = Provider.family<bool, String>((ref, reference) {
//   final controller = ref.watch(filesControllerProvider);
//   return controller.state.contains(reference);
// });
