// обновлённая простая модель: сохраняем и blobs, и trees
class TreeResponse {
  final List<TreeItem> items; // и 'blob', и 'tree'
  final bool? truncated;
  final String? sha; // sha корневого дерева, если пришла в ответе

  TreeResponse(this.items, {this.truncated, this.sha});

  factory TreeResponse.fromJson(Map<String, dynamic> json) {
    final list = (json['tree'] as List<dynamic>? ?? [])
        .map((e) => TreeItem.fromJson(e as Map<String, dynamic>))
        .toList();
    return TreeResponse(
      list,
      truncated: json['truncated'] as bool?,
      sha: json['sha'] as String?,
    );
  }
}

class TreeItem {
  final String path;
  final String type; // 'blob' | 'tree'
  final int? size;
  final String? sha;

  TreeItem({required this.path, required this.type, this.size, this.sha});

  factory TreeItem.fromJson(Map<String, dynamic> json) => TreeItem(
    path: json['path'] as String,
    type: json['type'] as String,
    size: json['size'] as int?,
    sha: json['sha'] as String?,
  );
}
