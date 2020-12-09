import 'dart:io';

import '../constantes.dart';

abstract class FileManager {
  final sb = StringBuffer();

  Future<void> save(String filename) async {
    final file = File('$kOutputsDirectory$filename');

    var sink = file.openWrite();
    sink.write(sb.toString());
    sb.clear();
    await sink.close();

    stdout.writeln('ツ new file => $kOutputsDirectory$filename');
  }

  void write(String string, [int x = 0]) {
    sb.writeln('${kIndent * x}$string');
  }

  void indent(String string, [int x = 1]) {
    sb.writeln('${kIndent * x}$string');
  }
}
