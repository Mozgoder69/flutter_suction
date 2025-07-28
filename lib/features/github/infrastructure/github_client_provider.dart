import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../settings/infrastructure/settings_store.dart';
import 'github_client.dart';

part 'github_client_provider.g.dart';

@Riverpod(keepAlive: true)
Future<GithubClient> githubClientAsync(Ref ref) async {
  final token = await SettingsStore().readGithubToken();
  final client = GithubClient(token: token);
  ref.onDispose(client.close);
  return client;
}
