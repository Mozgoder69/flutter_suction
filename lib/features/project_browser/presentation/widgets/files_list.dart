import 'package:flutter/material.dart';
import '../../domain/file_entry.dart';

class FilesList extends StatefulWidget {
  final List<FileEntry> files;
  final List<String> selected;
  final Map<String, int> indexMap;
  final ValueChanged<List<String>> onChange;
  const FilesList({
    super.key,
    required this.files,
    required this.selected,
    required this.indexMap,
    required this.onChange,
  });

  @override
  State<FilesList> createState() => _FilesListState();
}

class _FilesListState extends State<FilesList> {
  late Set<String> _selected = widget.selected.toSet();

  @override
  void didUpdateWidget(covariant FilesList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selected != widget.selected) {
      _selected = widget.selected.toSet();
    }
  }

  void _toggle(String path) {
    if (_selected.contains(path)) {
      _selected.remove(path);
    } else {
      _selected.add(path);
    }
    widget.onChange(_selected.toList(growable: false));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.files.length,
      itemBuilder: (c, i) {
        final f = widget.files[i];
        final sel = _selected.contains(f.path);
        final ix = widget.indexMap[f.path];
        final title = ix == null ? f.path : '[$ix] ${f.path}';
        return ListTile(
          dense: true,
          selected: sel,
          title: Text(title),
          trailing: sel ? const Icon(Icons.check) : null,
          onTap: () => _toggle(f.path),
        );
      },
    );
  }
}
