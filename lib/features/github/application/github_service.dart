import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../infrastructure/github_source.dart';
import '../../source_select/application/source_controller.dart';
import '../infrastructure/github_client_provider.dart';

part 'github_service.g.dart';

@riverpod
GitHubSource? githubSource(Ref ref) {
  final spec = ref.watch(sourceControllerProvider);
  if (spec == null || (spec.kind != 'github' && spec.kind != 'api')) {
    return null;
  }
  final client = ref.watch(githubClientAsyncProvider).asData?.value;
  if (client == null) {
    return null;
  }
  return spec.kind == 'github'
      ? GitHubSource(
          owner: spec.owner!,
          repo: spec.repo!,
          branch: spec.branch!,
          client: client,
        )
      : GitHubSource.fromApiUrl(spec.apiUrl!, client: client);
}
