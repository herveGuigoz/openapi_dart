import 'dart:io';

import 'package:riverpod/riverpod.dart';

import '../constantes.dart';
import '../providers.dart';

class FileManager {
  FileManager(
    this.read, {
    StringBuffer stringBuffer,
  }) : _stringBuffer = stringBuffer ?? StringBuffer();

  final StringBuffer _stringBuffer;
  Reader read;

  File getFile(String fileName) => File('${read(dirPathProvider)}${fileName}');

  Future<void> save(String fileName) async {
    await createDirectoryIfNotExist();
    final file = await getFile(fileName);
    var sink = file.openWrite();
    sink.write(_stringBuffer.toString());
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
    final dirPath = read(dirPathProvider);
    final dir = Directory(dirPath);
    await dir.create(recursive: true);
  }
}
