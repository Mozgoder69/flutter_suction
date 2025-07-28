import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' as p;

part 'file_entry.freezed.dart';
part 'file_entry.g.dart';

@freezed
abstract class FileEntry with _$FileEntry {
  const factory FileEntry({
    required String path, // относительный путь (posix)
    int? size,
    required String ext, // с точкой: ".dart" | "" если нет
    required Set<String> parents, // "lib", "lib/ui", ...
  }) = _FileEntry;

  factory FileEntry.fromJson(Map<String, dynamic> json) =>
      _$FileEntryFromJson(json);
}

FileEntry fileEntryFromPath(String relPath, {int? size}) {
  final norm = relPath.replaceAll('\\', '/');
  final ext = p.extension(norm);
  final parts = p.split(norm);
  final parents = <String>{};
  for (int i = 0; i < parts.length - 1; i++) {
    parents.add(p.joinAll(parts.take(i + 1)));
  }
  return FileEntry(path: norm, size: size, ext: ext, parents: parents);
}
