import '../../models/definition.dart';
import '../file_manager.dart';

mixin DartClassBuilder on FileManager {
  Definition get definition;
  String get className;

  void writeClassName() {
    if (definition?.description != null) {
      write('/// ${definition.description}');
    }

    write('class $className {');

    indent('const $className({');
    for (final property in definition.properties) {
      property.isRequired
          ? indent('@required this.${property.name},', 2)
          : indent('this.${property.name},', 2);
    }
    indent('});\n');
  }

  void writeProperty(Property property) {
    if (property?.description != null) {
      indent('// ${property.description}');
    }
    indent('final ${property.asString(read)};');
  }
}
