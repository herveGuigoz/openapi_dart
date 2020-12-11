import 'package:args/args.dart';

import 'main.dart';

class Args {
  static ArgParser get _argsParser => ArgParser()
    ..addOption(
      'remote',
      abbr: 'r',
      help: 'Swagger documentation url.',
    )
    ..addOption(
      'path',
      abbr: 'p',
      help: 'Open Api Path to parse.',
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

    if (argResults['help'] || remote == null || path == null) return _help();

    return main(remote, path);
  }

  static void _help() => print('usage:\n${_argsParser.usage}');
}
