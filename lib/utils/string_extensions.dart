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

  String allBefore(Pattern pattern) {
    ArgumentError.checkNotNull(pattern, 'pattern');
    final matchIterator = pattern.allMatches(this).iterator;
    Match match;
    while (matchIterator.moveNext()) {
      match = matchIterator.current;
    }
    if (match != null) {
      return substring(0, match.start);
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

  /// Returns a string with capitalized first character.
  String get capitalize {
    if (isEmpty) return this;

    return this[0].toUpperCase() + substring(1);
  }

  String get withoutBlankCharacters =>
      split(' ').map((e) => e.capitalize).join();
}

// Returns the joined elements of the list
// if the list is not null; otherwise null.
String join(List list, [String separator = '']) {
  if (list == null) {
    return null;
  }

  return list.join(separator);
}
