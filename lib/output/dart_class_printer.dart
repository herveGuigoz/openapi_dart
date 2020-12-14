import 'package:meta/meta.dart';
import 'package:riverpod/riverpod.dart';

import '../models/definition.dart';
import '../providers.dart';
import '../utils/string_extensions.dart';
import 'builder/dart_class_builder.dart';
import 'builder/freezed_class_builder.dart';
import 'file_manager.dart';
import 'imports_builder.dart';

class DartClassPrinter extends FileManager
    with ImportsBuilder, FreezedClassBuilder, DartClassBuilder {
  DartClassPrinter(
    Reader read, {
    @required String ref,
    @required String directory,
    String className,
  })  : _ref = ref,
        _className = className,
        super(read, directory);

  /// Reference to definition.
  final String _ref;

  /// Current class name.
  final String _className;

  bool get isFreezed => read(isFreezedClass);

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
    isFreezed ? writeFreezedClassName() : writeClassName();
    await _writeProperties();
    write('}');

    await save(fileName);
  }

  Future<void> _writeProperties() async {
    for (final property in definition.properties) {
      await _generateChildIfHasReferenceOnDocument(property);
      if (!isFreezed) writeProperty(property);
    }
  }

  Future<void> _generateChildIfHasReferenceOnDocument(Property property) async {
    if (!property.hasDefinition) return;
    await DartClassPrinter(
      read,
      ref: property.ref,
      directory: super.directory,
    ).generate();
  }
}

// TODO parameters output when `in` is path
// Map<String, Object> queryParameters({String a, String b}) {
//   final params = <String, Object>{};
//   if (a != null) params['a'] = a;

//   return params;
// }
