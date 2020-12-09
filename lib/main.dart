import 'package:args/args.dart';

import 'swagger.dart';

class Main {
  static ArgParser get _argsParser => ArgParser()
    ..addOption(
      'url',
      abbr: 'u',
      help: 'Required: Swagger documentation url.',
    )
    ..addOption(
      'iri',
      abbr: 'i',
      help: 'Required: IRI to parse.',
    )
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Displays help information.',
    );

  static Future<void> parse(List<String> args) async {
    final argResults = _argsParser.parse(args);

    final url = argResults['url'] as String;
    final iri = argResults['iri'] as String;

    if (argResults['help'] || url == null || iri == null) return _help();

    return _generate(url, iri);
  }

  static void _help() => print('usage:\n${_argsParser.usage}');

  static Future<void> _generate(String url, String iri) {
    return Swagger(url, iri).generateModels();
  }
}
