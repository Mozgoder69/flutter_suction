class SourceSpec {
  final String kind; // 'local' | 'github' | 'api'
  final String? path;
  final String? owner;
  final String? repo;
  final String? branch;
  final String? apiUrl;

  const SourceSpec._({
    required this.kind,
    this.path,
    this.owner,
    this.repo,
    this.branch,
    this.apiUrl,
  });

  const SourceSpec.local({required String path})
    : this._(kind: 'local', path: path);

  const SourceSpec.github({
    required String owner,
    required String repo,
    required String branch,
  }) : this._(kind: 'github', owner: owner, repo: repo, branch: branch);

  const SourceSpec.apiUrl(String url) : this._(kind: 'api', apiUrl: url);

  @override
  String toString() {
    return switch (kind) {
      'local' => path!,
      'github' => '$owner/$repo#$branch',
      'api' => apiUrl!,
      _ => 'unknown',
    };
  }
}
