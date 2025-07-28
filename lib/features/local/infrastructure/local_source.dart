import 'dart:io';
import 'package:path/path.dart' as p;

class LocalSource {
  final String root;
  LocalSource(this.root);

  @override
  String toString() => root;

  Future<List<String>> listFiles() async {
    final dir = Directory(root);
    if (!await dir.exists()) return const [];
    final out = <String>[];
    await for (final ent in dir.list(recursive: true, followLinks: false)) {
      if (ent is File) {
        final rel = p.relative(ent.path, from: root).replaceAll('\\', '/');
        out.add(rel);
      }
    }
    return out;
  }

  Future<String> readFile(String relPath) async {
    final file = File(p.join(root, relPath));
    return file.readAsString();
  }
}
