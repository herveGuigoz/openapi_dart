import 'dart:convert';
import 'dart:io';

import 'package:openapi_dart/models/result.dart';
import 'package:riverpod/all.dart';

import 'models/definition.dart';
import 'models/path.dart';
import 'models/reference.dart';
import 'network/repository.dart';
import 'output/definition_printer.dart';

/// OpenApi documentation url.
final urlProvider = Provider<String>(null);

/// User path to request as String
final pathProvider = Provider<String>(null);

final methodProvider = Provider<String>(null);

/// Output directory for generated files.
final dirPathProvider = Provider((_) => 'build/');

/// Parent file name where all `Part '...';` will be injected.
final mainFileNameProvider = Provider<String>((ref) {
  return 'models.dart';
});

/// Network call to load openApi documetation.
final specsProvider = FutureProvider<String>((ref) async {
  final url = ref.read(urlProvider);
  stdout.writeln('Loading spec from $url..');
  return Repository.loadJson(url);
});

/// All Definition list in openApi documentation.
final definitionsProvider = Provider<List<Definition>>((ref) {
  final definitions = <Definition>[];
  ref.read(specsProvider).whenData((value) {
    final map = json.decode(value) as Map<String, Object>;
    (map['definitions'] as Map<String, Object>).forEach((key, value) {
      definitions.add(
        Definition.fromKeyValue(key, value as Map<String, Object>),
      );
    });
  });

  return definitions;
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
final getResponseForPathAndMethod = Provider<Result<Reference>>((ref) {
  Reference reference;
  try {
    final path = ref.read(pathModelProvider).dataOrThrow;
    final method = ref.read(methodProvider).toLowerCase();
    final ressource = path.getRessourceByMethod(method);
    reference = Reference(
      value: ressource.responses.first.ref,
      description: ressource.responses.first.description,
    );
  } catch (err) {
    return Result.error(err.toString());
  }

  return Result.data(reference);
});

/// Translate openApi Property type to dart as String.
final propertyTypeToString = Provider.family<String, Property>((ref, param) {
  if (!param.hasDefinition) {
    return param.type == Array ? 'List<${param.subType}>' : '${param.type}';
  }

  final def = ref.read(definitionProvider(param.ref));
  if (param?.subType == null) {
    return '_${def.entity}';
  }

  return 'List<_${def.entity}>';
});

/// Where all `part '...';` will be saved.
final stringBufferProvider = Provider(
  (_) => StringBuffer()..writeln("import 'package:meta/meta.dart';\n"),
);

/// Generate file for given Definition.
final writeToFile = FutureProvider.autoDispose.family<void, Definition>(
  (ref, def) async => DefinitionPrinter(
    ref.read,
    def,
    isRequestDefinition: true,
  ).generate(),
);
