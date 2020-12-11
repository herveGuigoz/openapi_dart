import 'package:riverpod/riverpod.dart';

import '../models/definition.dart';
import 'file_manager.dart';
import '../providers.dart';
import '../utils.dart';

class DefinitionPrinter extends FileManager {
  DefinitionPrinter(
    Reader read,
    this.definition, {
    this.isMainClass = false,
  }) : super(read);

  final Definition definition;
  final bool isMainClass;

  String get _className {
    return isMainClass
        ? '${definition.entity}GetResponse'
        : '_${definition.entity}';
  }

  String get _fileName {
    var name = _className.toFileName();
    if (name[0] == '_') name = name.substring(1);

    return '$name.dart';
  }

  Future<void> generate() async {
    _writeImports();
    _writeClassName();
    await _writeProperties();
    write('}');

    await save(_fileName);
  }

  void _writeImports() {
    final mainFileName = read(mainFileNameProvider);
    final stringBuffer = read(stringBufferProvider);
    final output = "part '$_fileName';";

    if (!RegExp(output).hasMatch(stringBuffer.toString())) {
      stringBuffer.writeln(output);
    }

    write("part of '$mainFileName';\n");
  }

  void _writeClassName() {
    if (definition?.description != null) {
      write('/// ${definition.description}');
    }

    write('class $_className {');

    indent('const $_className({');
    for (final property in definition.properties) {
      indent('this.${property.name},', 2);
    }
    indent('});\n');
  }

  Future<void> _writeProperties() async {
    for (final property in definition.properties) {
      await _generateChildIfHasReferenceOnDocument(property);
      final type = read(propertyTypeToString(property));
      if (property?.description != null) {
        indent('// ${property.description}');
      }
      indent('final ${type} ${property.name};');
    }
  }

  Future<void> _generateChildIfHasReferenceOnDocument(Property property) async {
    if (!property.hasDefinition) return;
    final newDefToWrite = read(definitionProvider(property.ref));
    await DefinitionPrinter(read, newDefToWrite).generate();
  }
}
