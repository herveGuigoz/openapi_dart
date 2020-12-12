import 'package:meta/meta.dart';
import 'package:openapi_dart/output/imports_builder.dart';
import 'package:riverpod/riverpod.dart';

import '../models/definition.dart';
import '../providers.dart';
import '../utils/string_extensions.dart';
import 'dart_class_builder.dart';
import 'file_manager.dart';

class DartClassPrinter extends FileManager
    with ImportsBuilder, DartClassBuilder {
  DartClassPrinter(
    Reader read, {
    @required String ref,
    String className,
  })  : _ref = ref,
        _className = className,
        super(read);

  /// Reference to definition.
  final String _ref;

  /// Current class name.
  final String _className;

  @override
  Definition get definition => read(definitionProvider(_ref));

  @override
  String get className => _className ?? '_${definition.entity}';

  @override
  String get fileName {
    var name = className.toFileName();
    if (name[0] == '_') name = name.substring(1);

    return '$name.dart';
  }

  Future<void> generate() async {
    writeImports();
    writeClassName();
    await _writeProperties();
    write('}');

    await save(fileName);
  }

  Future<void> _writeProperties() async {
    for (final property in definition.properties) {
      await _generateChildIfHasReferenceOnDocument(property);
      writeProperty(property);
    }
  }

  Future<void> _generateChildIfHasReferenceOnDocument(Property property) async {
    if (!property.hasDefinition) return;
    await DartClassPrinter(read, ref: property.ref).generate();
  }
}
