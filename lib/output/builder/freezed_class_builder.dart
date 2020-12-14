import '../../models/definition.dart';
import '../file_manager.dart';

mixin FreezedClassBuilder on FileManager {
  Definition get definition;
  String get className;

  void writeFreezedClassName() {
    if (definition?.description != null) {
      write('/// ${definition.description}');
    }
    write('@freezed');
    write('abstract class $className with _\$$className {');
    indent('factory $className({');
    for (final property in definition.properties) {
      if (property?.description != null) {
        indent('// ${property.description}', 2);
      }
      property.isRequired
          ? indent('@required ${property.asString(read)},', 2)
          : indent('${property.asString(read)},', 2);
    }
    indent('}) = _$className;');
  }
}
