import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';

import '../../../core/utils/minify.dart';
import '../../status/application/progress_controller.dart';
import '../../status/domain/progress_state.dart';
import '../../settings/application/settings_controller.dart';
import '../application/viewer_controller.dart';
import '../application/load_result.dart';
import '../domain/content_piece.dart';
import 'widgets/file_panel.dart';
import 'widgets/langs.dart';
import '../../search/presentation/global_search_row.dart';

class EditorsPane extends StatefulWidget {
  final List<String> paths;
  const EditorsPane({Key? key, required this.paths}) : super(key: key);

  @override
  State<EditorsPane> createState() => _EditorsPaneState();
}

class _EditorsPaneState extends State<EditorsPane> {
  final _scroll = ScrollController();
  final Map<String, CodeController> _controllers = {};
  final Map<String, GlobalKey<FilePanelState>> _panelKeys = {};
  List<ContentPiece> _currentPieces = const [];

  @override
  void dispose() {
    for (final c in _controllers.values) c.dispose();
    _scroll.dispose();
    super.dispose();
  }

  CodeController _getControllerFor(ContentPiece p) {
    final existing = _controllers[p.path];
    if (existing != null) {
      if (existing.text != p.text) existing.text = p.text;
      return existing;
    }
    final ctrl = CodeController(
      text: p.text,
      language: languageForPath(p.path),
    );
    _controllers[p.path] = ctrl;
    return ctrl;
  }

  GlobalKey<FilePanelState> _getKeyFor(String path) =>
      _panelKeys.putIfAbsent(path, () => GlobalKey<FilePanelState>());

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (ctx, ref, _) {
        final loader = loadContentResultProvider(paths: widget.paths);

        // слушаем прогресс загрузки
        ref.listen<AsyncValue<LoadResult>>(loader, (prev, next) {
          final p = ref.read(progressControllerProvider.notifier);
          next.when(
            data: (res) {
              p
                ..setMessage('Loaded')
                ..setLevel(StatusLevel.pass)
                ..setValue(100);
              if (res.skippedLarge.isNotEmpty && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Skipped ${res.skippedLarge.length} large files',
                    ),
                  ),
                );
              }
            },
            loading: () {
              p
                ..setMessage('Loading files')
                ..setLevel(StatusLevel.info)
                ..setValue(60);
            },
            error: (e, _) {
              p
                ..setMessage('Loading error')
                ..setLevel(StatusLevel.fail)
                ..setValue(0);
            },
          );
        });

        final async = ref.watch(loader);
        final ui =
            ref.watch(settingsControllerProvider).value ?? const UiSettings();
        final minify = ui.minifyOnCopy;

        return async.when(
          data: (res) {
            final pieces = res.pieces;
            _currentPieces = pieces;
            if (pieces.isEmpty) {
              return const Center(
                child: Text('No files (too large or not found)'),
              );
            }
            for (final p in pieces) {
              _getControllerFor(p);
              _getKeyFor(p.path);
            }

            Future<void> copyAll() async {
              final buf = StringBuffer();
              for (final piece in pieces) {
                final text = minify
                    ? minifyContent(_controllers[piece.path]!.text)
                    : _controllers[piece.path]!.text;
                buf
                  ..writeln('```${piece.path}')
                  ..writeln(text)
                  ..writeln('```');
              }
              await Clipboard.setData(ClipboardData(text: buf.toString()));
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      minify ? 'All minified & copied' : 'All copied',
                    ),
                  ),
                );
              }
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                  child: Row(
                    children: [
                      const Expanded(child: GlobalSearchRow(isMobile: false)),
                      const SizedBox(width: 8),
                      IconButton(
                        tooltip: 'Copy all',
                        icon: const Icon(Icons.copy_all),
                        onPressed: copyAll,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Expanded(
                  child: ListView.builder(
                    controller: _scroll,
                    itemCount: pieces.length,
                    itemBuilder: (c, i) {
                      final piece = pieces[i];
                      return FilePanel(
                        key: _panelKeys[piece.path],
                        piece: piece,
                        controller: _controllers[piece.path]!,
                        controllerOwned: false,
                      );
                    },
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
        );
      },
    );
  }
}
