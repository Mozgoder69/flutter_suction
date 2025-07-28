import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/types/result.dart';
import '../../github/infrastructure/models/tree_response.dart';
import '../../status/application/progress_controller.dart';
import '../../status/domain/progress_state.dart';
import '../domain/browser_state.dart';
import '../domain/file_entry.dart';
import 'browser_controller.dart';

part 'browser_state_controller.g.dart';

bool _isParent(String parent, String child) {
  if (parent.isEmpty || child.isEmpty) return false;
  if (parent == child) return true;
  // сравнение posix-путей: "lib" является родителем "lib/a/b"
  return child.startsWith(parent) &&
      child.length > parent.length &&
      child[parent.length] == '/';
}

Set<String> _normalizeExcluded(Set<String> input) {
  final list = input.toList()
    ..sort(
      (a, b) => a.length.compareTo(b.length),
    ); // короткие (родители) раньше
  final out = <String>{};
  for (final d in list) {
    if (out.any((p) => _isParent(p, d))) {
      // d покрыт уже добавленным родителем — пропускаем
      continue;
    }
    out.add(d);
  }
  return out;
}

@riverpod
class BrowserStateController extends _$BrowserStateController {
  @override
  FutureOr<BrowserState> build() async {
    final res = await ref.watch(browserControllerProvider.future);
    if (res is Err<TreeResponse>) {
      // Пробрасываем ошибку — UI покажет её через .when(error: ...)
      return Future.error(res.error, res.stackTrace);
    }
    final tree = (res as Ok<TreeResponse>).value;
    final files = <FileEntry>[];
    final allDirs = <String>{};
    final allExts = <String>{};

    final p = ref.read(progressControllerProvider.notifier);
    p
      ..setMessage('Parsing files')
      ..setLevel(StatusLevel.info)
      ..setValue(50);

    final total = tree.items.isEmpty ? 1 : tree.items.length;
    var processed = 0;

    for (final item in tree.items) {
      processed++;
      if (item.type == 'blob') {
        final fe = fileEntryFromPath(item.path, size: item.size);
        files.add(fe);
        allExts.add(fe.ext);
        allDirs.addAll(fe.parents);
      }
      // шкала 50..90
      if ((processed & 15) == 0 || processed == total) {
        final v = (50 + (processed / total) * 40).round().clamp(50, 90);
        p.setValue(v);
      }
    }

    p
      ..setMessage('Building state')
      ..setLevel(StatusLevel.info)
      ..setValue(95);

    allDirs.remove('');
    allExts.removeWhere((e) => e.isEmpty);

    // Изначально показываем все файлы без фильтрации.
    final s = BrowserState(
      allFiles: files,
      allDirs: allDirs,
      allExts: allExts,
      filteredFiles: files,
    );

    p
      ..setMessage('Scanning Complete')
      ..setLevel(StatusLevel.pass)
      ..setValue(100);

    return s;
  }

  /// Внутренняя функция фильтрации.
  List<FileEntry> _filterFiles(
    List<FileEntry> all,
    Set<String> excludedDirs,
    Set<String> includedExts,
  ) {
    bool dirExcluded(FileEntry f) =>
        excludedDirs.isNotEmpty && f.parents.any(excludedDirs.contains);
    bool extIncluded(FileEntry f) =>
        includedExts.isEmpty || includedExts.contains(f.ext);

    return [
      for (final f in all)
        if (!dirExcluded(f) && extIncluded(f)) f,
    ];
  }

  /// Пересобрать карту индексов только для видимых (отфильтрованных) выбранных файлов.
  Map<String, int> _buildIndexMap(
    List<String> selected,
    List<FileEntry> filtered,
  ) {
    final visible = <String>{for (final f in filtered) f.path};
    final result = <String, int>{};
    var i = 1;
    for (final p in selected) {
      if (visible.contains(p)) {
        result[p] = i++;
      }
    }
    return result;
  }

  /// Применяет фильтры к базовому состоянию и сохраняет новое состояние.
  void _applyFilters(BrowserState base) {
    final filtered = _filterFiles(
      base.allFiles,
      base.excludedDirs,
      base.includedExts,
    );
    final idx = _buildIndexMap(base.selectedPaths, filtered);
    state = AsyncData(
      base.copyWith(filteredFiles: filtered, selectedIndexByPath: idx),
    );
  }

  // --- Публичные методы, вызываемые UI ---

  void toggleExcludeDir(String dir) {
    final s = state.asData?.value ?? const BrowserState();
    final excluded = <String>{...s.excludedDirs};
    if (excluded.contains(dir)) {
      excluded.remove(dir);
    } else {
      excluded.add(dir);
    }
    final normalized = _normalizeExcluded(excluded);
    _applyFilters(s.copyWith(excludedDirs: normalized));
  }

  void toggleIncludeExt(String ext) {
    final s = state.asData?.value ?? const BrowserState();
    final included = <String>{...s.includedExts};
    if (included.contains(ext)) {
      included.remove(ext);
    } else {
      included.add(ext);
    }
    _applyFilters(s.copyWith(includedExts: included));
  }

  void setSelectedPaths(List<String> paths) {
    final s = state.asData?.value ?? const BrowserState();
    final visible = <String>{for (final f in s.filteredFiles) f.path};
    final sel = <String>[];
    final seen = <String>{};
    for (final pth in paths) {
      if (visible.contains(pth) && seen.add(pth)) {
        sel.add(pth);
      }
    }
    final map = _buildIndexMap(sel, s.filteredFiles);
    state = AsyncData(s.copyWith(selectedPaths: sel, selectedIndexByPath: map));
  }

  /// Применяем внешнее состояние (загруженная выборка).
  /// 1) Подставляем директории/расширения.
  /// 2) Фильтруем файлы.
  /// 3) Пересекаем выбранные с видимыми и заново нумеруем.
  void applyExternalState(BrowserState external) {
    final normDirs = _normalizeExcluded(external.excludedDirs);
    final filtered = _filterFiles(
      external.allFiles,
      normDirs,
      external.includedExts,
    );
    final visible = <String>{for (final f in filtered) f.path};
    final selected = <String>[
      for (final p in external.selectedPaths)
        if (visible.contains(p)) p,
    ];
    final idx = _buildIndexMap(selected, filtered);
    state = AsyncData(
      external.copyWith(
        excludedDirs: normDirs,
        filteredFiles: filtered,
        selectedPaths: selected,
        selectedIndexByPath: idx,
      ),
    );
  }
}
