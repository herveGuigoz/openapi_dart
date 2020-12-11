extension StringExt on String {
  String allAfter(Pattern pattern) {
    ArgumentError.checkNotNull(pattern, 'pattern');
    final matchIterator = pattern.allMatches(this).iterator;
    if (matchIterator.moveNext()) {
      final match = matchIterator.current;
      final length = match.end - match.start;
      return substring(match.start + length);
    }
    return '';
  }

  String toFileName() {
    var res = this;
    final pattern = '[A-Z]';
    final exp = RegExp(pattern);
    final matchIterator = exp.allMatches(res);
    for (final m in matchIterator) {
      final match = m.group(0);
      res = res.replaceAll(RegExp(match), '_${match.toLowerCase()}');
    }

    if (res[0] == '_') res = res.substring(1);

    return res;
  }
}
