import 'package:args/args.dart';

import 'main.dart';

class Args {
  static ArgParser get _argsParser => ArgParser()
    ..addOption(
      'remote',
      abbr: 'r',
      valueHelp: '../docs.json',
      help: 'OpenApi documentation url.',
    )
    ..addOption(
      'path',
      abbr: 'p',
      valueHelp: '/books/{id}',
      help: 'OpenApi Path to translate.',
    )
    ..addOption(
      'method',
      abbr: 'm',
      allowed: ['GET', 'POST', 'PUT'],
      help: 'Request method to translate.',
      defaultsTo: 'GET',
    )
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Displays help information.',
    );

  static Future<void> parse(List<String> args) async {
    final argResults = _argsParser.parse(args);

    final remote = argResults['remote'] as String;
    final path = argResults['path'] as String;
    final method = argResults['method'] as String;

    if (argResults['help'] || remote == null || path == null) return _help();

    return main(remote, path, method);
  }

  static void _help() => print('usage:\n${_argsParser.usage}');
}
