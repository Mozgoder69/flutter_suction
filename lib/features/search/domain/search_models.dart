class GlobalSearchHit {
  final String path;
  final int count;
  GlobalSearchHit(this.path, this.count);
}

class GlobalSearchResult {
  final String query;
  final List<GlobalSearchHit> hits;
  final List<String> skippedLarge;
  const GlobalSearchResult({
    required this.query,
    required this.hits,
    this.skippedLarge = const [],
  });
}
