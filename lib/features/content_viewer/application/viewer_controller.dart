import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../github/application/github_service.dart';
import '../../local/application/local_service.dart';
import '../../settings/domain/app_settings.dart';
import '../domain/content_piece.dart';
import 'load_result.dart';

part 'viewer_controller.g.dart';

@riverpod
Future<LoadResult> loadContentResult(
  Ref ref, {
  required List<String> paths,
}) async {
  final gh = ref.watch(githubSourceProvider);
  final local = ref.watch(localSourceProvider);
  if (gh == null && local == null) return const LoadResult([], []);

  final maxSize = AppSettings.maxFileSize;
  final pieces = <ContentPiece>[];
  final skipped = <String>[];

  for (final rel in paths) {
    final text = gh != null
        ? await gh.readFile(rel)
        : await local!.readFile(rel);
    final len = utf8.encode(text).length;
    if (len > maxSize) {
      skipped.add(rel);
      continue;
    }
    pieces.add(ContentPiece(rel, text));
  }
  return LoadResult(pieces, skipped);
}
