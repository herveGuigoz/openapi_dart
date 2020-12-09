import 'package:swagger_models_generator/models/models.dart';
import 'package:swagger_models_generator/output/file_manager.dart';

import '../utils.dart';

class ClassManager extends FileManager {
  ClassManager(this.definition);

  final Definition definition;

  String get className => definition.name.split('-')[0];

  Future<void> generate() async {
    write('class $className {');

    indent('const $className({');
    for (final props in definition.properties) {
      indent('this.${props.name},', 2);
    }
    indent('});\n');

    for (final props in definition.properties) {
      if (props?.description != null) {
        indent('/// ${props.description}');
      }
      indent('final ${props.type} ${props.name};\n');
    }

    write('}');

    await save('${className.toFileName()}.dart');
  }
}
