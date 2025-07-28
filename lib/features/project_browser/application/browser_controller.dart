import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../source_select/application/source_controller.dart';
import '../../github/infrastructure/github_source.dart';
import '../../github/infrastructure/github_client_provider.dart';
import '../../github/infrastructure/models/tree_response.dart';
import '../../../core/types/result.dart';
import '../../local/infrastructure/local_source.dart';

part 'browser_controller.g.dart';

@riverpod
class BrowserController extends _$BrowserController {
  @override
  Future<Result<TreeResponse>> build() async {
    final spec = ref.watch(sourceControllerProvider);
    if (spec == null) {
      return const Err('No source selected');
    }

    if (spec.kind == 'github') {
      try {
        final client = await ref.read(githubClientAsyncProvider.future);
        final source = GitHubSource(
          owner: spec.owner!,
          repo: spec.repo!,
          branch: spec.branch!,
          client: client,
        );
        final tree = await source.fetchTreeFull();
        return Ok(tree);
      } catch (e, st) {
        return Err(e, st);
      }
    }

    if (spec.kind == 'api') {
      try {
        final client = await ref.read(githubClientAsyncProvider.future);
        final src = GitHubSource.fromApiUrl(spec.apiUrl!, client: client);
        final tree = await src.fetchTreeFull();
        return Ok(tree);
      } catch (e, st) {
        return Err(e, st);
      }
    }

    if (spec.kind == 'local') {
      try {
        final src = LocalSource(spec.path!);
        final files = await src.listFiles();
        final items = <TreeItem>[
          for (final rel in files)
            TreeItem(path: rel, type: 'blob', size: null, sha: null),
        ];
        return Ok(TreeResponse(items, truncated: false));
      } catch (e, st) {
        return Err(e, st);
      }
    }

    return const Err('Unknown source kind');
  }
}
