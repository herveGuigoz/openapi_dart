import 'dart:convert';
import 'dart:io';

import 'package:riverpod/all.dart';

import 'models/definition.dart';
import 'models/path.dart';
import 'models/result.dart';
import 'network/repository.dart';
import 'utils/json_parser.dart';
import 'utils/string_extensions.dart';

/// Directory to write files on.
final directoryProvider = Provider<String>(null);

/// File system ressource.
final fileProvider = Provider<String>(null);

/// Remote resource.
final urlProvider = Provider<String>(null);

/// Remote header.
final httpHeaderProvider = Provider<Map<String, String>>(null);

/// User path to request as String.
final pathProvider = Provider<String>(null);

/// Http method to handle.
final methodProvider = Provider<String>(null);

/// If false output will be Dart class.
final isFreezedClass = Provider<bool>((_) => false);

/// Parent file name where all `Part '...';` will be injected.
final mainResponseFileNameProvider = Provider<String>((ref) {
  return 'models.dart';
});

/// Load openApi documetation.
final specsProvider = FutureProvider<String>((ref) async {
  final filePath = ref.read(fileProvider);
  final url = ref.read(urlProvider);
  final header = ref.read(httpHeaderProvider);

  filePath != null
      ? stdout.writeln('Loading spec from $filePath..')
      : stdout.writeln('Loading spec from $url..');

  return Repository.loadJson(filePath: filePath, url: url, headers: header);
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

/// Get reference for response definition.
final getRessourcesForPath = Provider<Result<Ressource>>((ref) {
  Ressource ressource;
  try {
    final path = ref.read(pathModelProvider).dataOrThrow;
    final method = ref.read(methodProvider);
    ressource = path.getRessourceByMethod(method);
  } catch (err) {
    return Result.error(err.toString());
  }

  return Result.data(ressource);
});

/// Where all `part '...';` will be saved.
final stringBufferProvider = Provider<StringBuffer>((ref) {
  final isFreezed = ref.read(isFreezedClass);
  final buffer = StringBuffer()..writeln("import 'package:meta/meta.dart';\n");
  if (isFreezed) {
    final fileName = ref.read(mainResponseFileNameProvider).allBefore('.dart');
    buffer
      ..writeln(
        "import 'package:freezed_annotation/freezed_annotation.dart';\n",
      )
      ..writeln("part '$fileName.freezed.dart';\n");
  }

  return buffer;
});
