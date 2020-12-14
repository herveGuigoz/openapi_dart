import '../../providers.dart';
import '../file_manager.dart';

mixin ImportsBuilder on FileManager {
  String get fileName;

  void writeImports() {
    final mainFileName = read(mainResponseFileNameProvider);
    final stringBuffer = read(stringBufferProvider);
    final output = "part '$fileName';";

    if (!RegExp(output).hasMatch(stringBuffer.toString())) {
      stringBuffer.writeln(output);
    }

    write("part of '$mainFileName';\n");
  }
}
