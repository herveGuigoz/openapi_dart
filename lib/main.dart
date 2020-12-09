import 'package:args/args.dart';
import 'package:swagger_models_generator/output/file_manager.dart';

import 'models/models.dart';
import 'network/repository.dart';
import 'output/class_manager.dart';

Future<void> main(String url, String iri) async {
  final files = <String>[];

  final response = await Repository.loadJson(url);
  final doc = Document.fromRawJson(response);

  final methodGET = doc.getPathByName(iri).methodGET;

  final definition = doc.getDefinitionByName(methodGET.ref);

  await ClassManager(definition).generate().then((value) => files.add(value));

  final refs = definition.refs;
  for (final ref in refs) {
    await ClassManager(doc.getDefinitionByName(ref))
        .generate()
        .then((value) => files.add(value));
    ;
  }

  await ModelsFileManager().writeModelsFile(files);

  return;
}

class ModelsFileManager extends FileManager {
  Future<void> writeModelsFile(List<String> files) async {
    for (final file in files) {
      write("part '$file';");
    }

    await save('models.dart');
  }
}
