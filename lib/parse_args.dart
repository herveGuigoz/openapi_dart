import 'package:args/args.dart';

import 'main.dart';

class Args {
  static ArgParser get _argsParser => ArgParser()
    ..addOption(
      'remote',
      abbr: 'r',
      valueHelp: 'https://petstore.swagger.io/v2/swagger.json',
      help: 'Reading specs from remote resource',
    )
    ..addOption(
      'json',
      abbr: 'j',
      valueHelp: 'swagger.json',
      help: 'Reading specs from file system',
    )
    ..addOption(
      'header',
      abbr: 'h',
      valueHelp: "'Authorization: Bearer ACCESS_TOKEN'",
      help: 'Add header on remote documentation',
    )
    ..addOption(
      'path',
      abbr: 'p',
      valueHelp: '/books/{id}',
      help: '(required) OpenApi Path to translate.',
    )
    ..addOption(
      'method',
      abbr: 'm',
      allowed: ['GET', 'POST', 'PUT'],
      help: 'Path request method to translate.',
      defaultsTo: 'GET',
    )
    ..addOption(
      'output',
      abbr: 'o',
      help: 'Where files will be saved.',
      defaultsTo: 'build/',
    )
    ..addFlag(
      'freezed',
      abbr: 'f',
      negatable: false,
      help: 'Output freezed class.',
    )
    ..addFlag(
      'help',
      negatable: false,
      help: 'Displays help information.',
    );

  static Future<void> parse(List<String> args) async {
    final argResults = _argsParser.parse(args);

    final help = argResults['help'] as bool;
    final header = argResults['header'] as String;
    final file = argResults['json'] as String;
    final remote = argResults['remote'] as String;
    final path = argResults['path'] as String;
    final method = argResults['method'] as String;
    final directory = argResults['output'] as String;
    final freezed = argResults['freezed'] as bool;

    if (help || path == null || (remote == null && file == null)) {
      return _help();
    }

    return main(
      file: file,
      url: remote,
      path: path,
      methods: method,
      dir: directory,
      freezed: freezed,
      header: header,
    );
  }

  static void _help() => print('usage:\n${_argsParser.usage}');
}
