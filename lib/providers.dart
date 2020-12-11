import 'dart:io';
import 'dart:convert';

import 'package:riverpod/all.dart';
import 'package:swagger_models_generator/models/definition.dart';

import 'models/path.dart';
import 'network/repository.dart';
import 'output/definition_printer.dart';

final urlProvider = Provider<String>(null);

final directoryProvider = Provider((_) => 'build');

final mainFileNameProvider = Provider<String>((ref) {
  final directory = ref.read(directoryProvider);
  return '$directory/output.dart';
});

final specsProvider = FutureProvider<String>((ref) async {
  final url = ref.read(urlProvider);
  stdout.writeln('Loading spec from $url..');
  return Repository.loadJson(url);
});

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

final definitionProvider = Provider.family<Definition, String>((ref, param) {
  return ref.read(definitionsProvider).firstWhere((def) => def.name == param);
});

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

final pathProvider = Provider.family<Path, String>((ref, param) {
  return ref.read(pathsProvider).firstWhere((path) => path.iri == param);
});

final propertyTypeToString = Provider.family<String, Property>((ref, param) {
  if (!param.hasDefinition) {
    return param.type == Array ? 'List<${param.subType}>' : '${param.type}';
  }

  final def = ref.read(definitionProvider(param.ref));
  if (param?.subType == null) {
    return '${def.entity}';
  }

  return 'List<${def.entity}>';
});

// final stringBufferProvider = Provider.autoDispose((ref) {
//   final buffer = StringBuffer();

//   return buffer;
// });

// final fileProvider = Provider((_) => File('${kOutputsDirectory}output.dart'));

final writeToFile = FutureProvider.autoDispose.family<void, Definition>(
  (ref, def) async => DefinitionPrinter(ref.read, def).generate(),
);
