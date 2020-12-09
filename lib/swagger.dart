import 'package:swagger_models_generator/network/repository.dart';
import 'package:swagger_models_generator/output/class_manager.dart';

import 'models/models.dart';

class Swagger {
  Swagger(this.url, this.iri);

  final String url;
  final String iri;

  Future<void> generateModels() async {
    final response = await Repository.loadJson(url);
    final doc = Document.fromRawJson(response);

    final methodGET = doc.getPathByName(iri).methodGET;

    final definition = doc.getDefinitionByName(methodGET.ref);

    await ClassManager(definition).generate();

    await _iterateOverRefs(doc, definition);
  }

  Future<void> _iterateOverRefs(
    Document doc,
    Definition definition,
  ) async {
    final refs = definition.refs;
    for (final ref in refs) {
      await ClassManager(doc.getDefinitionByName(ref)).generate();
    }
  }
}
