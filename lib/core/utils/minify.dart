final _tag = RegExp(r'<(/?[A-Za-z][A-Za-z0-9\-]*)(.*?)(/?)>', dotAll: true);
final _rn = RegExp(r'[\r\n]+');
final _spaces2 = RegExp(r'\s{2,}');
final _leading = RegExp(r'^[ \t]+(?=<)', multiLine: true);

String minifyWebTags(String content) {
  return content
      .replaceAllMapped(_tag, (m) {
        final tag = m.group(1)!;
        var inner = m.group(2) ?? '';
        final slash = m.group(3) ?? '';
        inner = inner.replaceAll(_rn, ' ');
        inner = inner.replaceAll(_spaces2, ' ').trim();
        return inner.isEmpty ? '<$tag$slash>' : '<$tag $inner$slash>';
      })
      .replaceAll(_leading, '');
}

String minifyContent(String content) {
  if (content.isEmpty) return content;
  content = content.split(',\n').map((e) => e.trim()).join(', ');
  content = content.replaceAll('\n\n', '\n');
  return minifyWebTags(content);
}
