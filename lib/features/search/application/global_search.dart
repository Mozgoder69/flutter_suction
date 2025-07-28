import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../settings/domain/app_settings.dart';
import '../../github/application/github_service.dart';
import '../../local/application/local_service.dart';
import '../../project_browser/application/browser_state_controller.dart';
import '../../status/application/progress_controller.dart';
import '../../status/domain/progress_state.dart';
import '../domain/search_models.dart';

part 'global_search.g.dart';

@riverpod
Future<GlobalSearchResult> globalSearch(
  Ref ref, {
  required String query,
}) async {
  final s = await ref.watch(browserStateControllerProvider.future);

  // Всегда ищем по уже отфильтрованным файлам, без чувствительности к регистру.
  final files = s.filteredFiles;

  final gh = ref.watch(githubSourceProvider);
  final local = ref.watch(localSourceProvider);
  final maxSize = AppSettings.maxFileSize;

  if (gh == null && local == null) {
    return GlobalSearchResult(query: query, hits: const []);
  }

  final p = ref.read(progressControllerProvider.notifier);
  p
    ..setMessage('Searching…')
    ..setLevel(StatusLevel.info)
    ..setValue(0);

  final hits = <GlobalSearchHit>[];
  final skippedLarge = <String>[];
  final q = query.toLowerCase();

  for (var i = 0; i < files.length; i++) {
    final rel = files[i].path;
    final text = gh != null
        ? await gh.readFile(rel)
        : await local!.readFile(rel);
    final bytes = utf8.encode(text);
    if (bytes.length > maxSize) {
      skippedLarge.add(rel);
      final v = ((i + 1) / files.length * 100).round().clamp(0, 100);
      p.setValue(v);
      continue;
    }

    final hay = text.toLowerCase();
    var from = 0, cnt = 0;
    while (true) {
      final ix = hay.indexOf(q, from);
      if (ix < 0) break;
      cnt++;
      from = ix + q.length;
    }
    if (cnt > 0) {
      hits.add(GlobalSearchHit(rel, cnt));
    }

    final v = ((i + 1) / files.length * 100).round().clamp(0, 100);
    p.setValue(v);
  }

  p
    ..setMessage('Search complete')
    ..setLevel(StatusLevel.pass)
    ..setValue(100);

  // сортируем по количеству совпадений (desc), затем по пути
  hits.sort((a, b) {
    final d = b.count.compareTo(a.count);
    return d != 0 ? d : a.path.compareTo(b.path);
  });

  return GlobalSearchResult(
    query: query,
    hits: hits,
    skippedLarge: skippedLarge,
  );
}
