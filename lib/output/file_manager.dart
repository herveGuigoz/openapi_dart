import 'dart:io';

import 'package:riverpod/riverpod.dart';

import '../constantes.dart';

class FileManager {
  FileManager(
    this.read,
    this.directory, {
    StringBuffer stringBuffer,
  }) : _stringBuffer = stringBuffer ?? StringBuffer();

  final StringBuffer _stringBuffer;
  Reader read;
  final String directory;

  File getFile(String fileName) => File('$directory$fileName');

  Future<void> save(String fileName) async {
    await createDirectoryIfNotExist();
    final file = getFile(fileName);
    var sink = file.openWrite()..write(_stringBuffer.toString());
    _stringBuffer.clear();
    await sink.close();

    stdout.writeln('ツ new file => ${file.uri}');
  }

  void write(String string, [int x = 0]) {
    _stringBuffer.writeln('${kIndent * x}$string');
  }

  void indent(String string, [int x = 1]) {
    _stringBuffer.writeln('${kIndent * x}$string');
  }

  Future<void> createDirectoryIfNotExist() async {
    final dir = Directory(directory);
    await dir.create(recursive: true);
  }
}
