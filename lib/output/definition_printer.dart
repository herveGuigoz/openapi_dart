import 'package:riverpod/riverpod.dart';

import '../models/definition.dart';
import '../models/path.dart';
import '../providers.dart';
import '../utils.dart';
import 'file_manager.dart';

class DefinitionPrinter extends FileManager {
  DefinitionPrinter(
    Reader read,
    this.definition, {
    this.isRequestDefinition = false,
  }) : super(read);

  final Definition definition;
  final bool isRequestDefinition;

  String get _className {
    return isRequestDefinition
        ? _responseModel?.description?.withoutBlankCharacters ?? 'Response'
        : '_${definition.entity}';
  }

  String get _fileName {
    var name = _className.toFileName();
    if (name[0] == '_') name = name.substring(1);

    return '$name.dart';
  }

  Response get _responseModel => read(getResponseForPathAndMethod);

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
      _isRequiredProperty(property)
          ? indent('@required this.${property.name},', 2)
          : indent('this.${property.name},', 2);
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

  bool _isRequiredProperty(Property property) {
    final requiredProperties = definition?.requiredProperties ?? [];
    return requiredProperties.contains(property.name);
  }

  Future<void> _generateChildIfHasReferenceOnDocument(Property property) async {
    if (!property.hasDefinition) return;
    final newDefToWrite = read(definitionProvider(property.ref));
    await DefinitionPrinter(read, newDefToWrite).generate();
  }
}
