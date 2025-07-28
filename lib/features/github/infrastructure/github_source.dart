import 'package:path/path.dart' as p;
import 'models/tree_response.dart';
import 'github_client.dart';

class GitHubSource {
  final String owner;
  final String repo;
  final String branch;
  final GithubClient client;

  GitHubSource({
    required this.owner,
    required this.repo,
    required this.branch,
    required this.client,
  });

  Uri get treeUri => Uri.https(
    'api.github.com',
    '/repos/$owner/$repo/git/trees/$branch',
    {'recursive': '1'},
  );

  factory GitHubSource.fromApiUrl(String url, {required GithubClient client}) {
    final re = RegExp(
      r'https://api.github.com/repos/([^/]+)/([^/]+)/git/trees/([^?]+)',
    );
    final m = re.firstMatch(url);
    if (m == null) throw ArgumentError('Invalid GitHub tree URL: $url');
    return GitHubSource(
      owner: m.group(1)!,
      repo: m.group(2)!,
      branch: m.group(3)!,
      client: client,
    );
  }

  String rawBase() => 'https://raw.githubusercontent.com/$owner/$repo/$branch/';

  Future<TreeResponse> fetchTree() async {
    final json = await client.getJson(treeUri);
    return TreeResponse.fromJson(json);
  }

  /// Полная загрузка дерева, если корневой ответ был усечён (truncated).
  /// Стратегия: пройтись по элементам type=='tree' и для каждого sha
  /// запросить `/git/trees/{sha}?recursive=1`, добавляя `blob`-элементы
  /// с префиксом пути этой директории. Повторять, если поддерево тоже усечено.
  Future<TreeResponse> fetchTreeFull() async {
    final root = await fetchTree();
    if (root.truncated != true) {
      return root;
    }

    // карта sha директории -> её путь (префикс)
    final dirPrefix = <String, String>{};
    for (final it in root.items.where((e) => e.type == 'tree')) {
      final sha = it.sha;
      if (sha != null) dirPrefix[sha] = it.path;
    }

    final blobs = <TreeItem>[
      // уже известные blobs из усечённого корня
      ...root.items.where((e) => e.type == 'blob'),
    ];

    // очередь на обход: sha директории
    final queue = <String>[...dirPrefix.keys];

    // чтобы не зациклиться
    final visited = <String>{};

    while (queue.isNotEmpty) {
      final sha = queue.removeLast();
      if (!visited.add(sha)) continue;

      final uri = Uri.https(
        'api.github.com',
        '/repos/$owner/$repo/git/trees/$sha',
        {'recursive': '1'},
      );
      final json = await client.getJson(uri);
      final resp = TreeResponse.fromJson(json);

      final prefix = dirPrefix[sha] ?? '';

      // добавляем blobs c префиксом
      for (final it in resp.items.where((e) => e.type == 'blob')) {
        final fullPath = prefix.isEmpty
            ? it.path
            : p.posix.join(prefix, it.path);
        blobs.add(
          TreeItem(path: fullPath, type: 'blob', size: it.size, sha: it.sha),
        );
      }

      // если поддерево тоже усечено — продолжаем спуск
      if (resp.truncated == true) {
        for (final t in resp.items.where((e) => e.type == 'tree')) {
          final childSha = t.sha;
          if (childSha == null) continue;
          final childPrefix = prefix.isEmpty
              ? t.path
              : p.posix.join(prefix, t.path);
          // запоминаем префикс
          dirPrefix[childSha] = childPrefix;
          queue.add(childSha);
        }
      }
    }

    return TreeResponse(blobs, truncated: false);
  }

  Future<String> readFile(String relPath) {
    final url = Uri.parse('${rawBase()}${relPath.replaceAll("\\", "/")}');
    return client.getText(url);
  }
}
