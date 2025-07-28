import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';

import '../application/load_result.dart';
import '../application/viewer_controller.dart';
import '../domain/content_piece.dart';
import 'widgets/file_panel.dart';
import 'widgets/langs.dart';
import '../../../core/utils/minify.dart';
import '../../status/presentation/progress_bar.dart';
import '../../status/application/progress_controller.dart';
import '../../status/domain/progress_state.dart';
import '../../settings/application/settings_controller.dart';
import '../../search/application/jump_to_file.dart';

class ViewerPage extends StatefulWidget {
  final List<String> selectedPaths;
  const ViewerPage({Key? key, required this.selectedPaths}) : super(key: key);

  @override
  State<ViewerPage> createState() => _ViewerPageState();
}

class _ViewerPageState extends State<ViewerPage> {
  final _scroll = ScrollController();
  final Map<String, CodeController> _controllers = {};
  final Map<String, GlobalKey<FilePanelState>> _panelKeys = {};
  List<ContentPiece> _pieces = const [];

  @override
  void dispose() {
    for (final c in _controllers.values) c.dispose();
    _scroll.dispose();
    super.dispose();
  }

  // Помогает создать/обновить CodeController
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

  String _wrapAll(List<ContentPiece> pieces, {required bool minified}) {
    final buf = StringBuffer();
    for (final p in pieces) {
      final text = minified
          ? minifyContent(_controllers[p.path]!.text)
          : _controllers[p.path]!.text;
      buf
        ..writeln('```${p.path}')
        ..writeln(text)
        ..writeln('```');
    }
    return buf.toString();
  }

  void _handleJump(JumpCommand cmd) async {
    final key = _panelKeys[cmd.path];
    if (key?.currentContext != null) {
      await Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 280),
        alignment: 0.05,
      );
      key.currentState?.jumpToQuery(cmd.query);
      return;
    }
    final idx = _pieces.indexWhere((e) => e.path == cmd.path);
    if (idx >= 0) {
      _scroll.animateTo(
        (idx * 520).toDouble(),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final k = _panelKeys[cmd.path];
        if (k?.currentContext != null) {
          k!.currentState?.jumpToQuery(cmd.query);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (ctx, ref, _) {
        final loader = loadContentResultProvider(paths: widget.selectedPaths);

        // теперь слушаем loader ВНУТРИ Consumer.builder
        ref.listen<AsyncValue<LoadResult>>(loader, (prev, next) {
          final p = ref.read(progressControllerProvider.notifier);
          next.when(
            data: (_) => p
              ..setMessage('Loaded')
              ..setLevel(StatusLevel.pass)
              ..setValue(100),
            loading: () => p
              ..setMessage('Loading files')
              ..setLevel(StatusLevel.info)
              ..setValue(0),
            error: (_, __) => p
              ..setMessage('Loading error')
              ..setLevel(StatusLevel.fail)
              ..setValue(0),
          );
        });

        // слушаем глобальный Jump
        ref.listen<JumpCommand?>(searchJumpProvider, (prev, next) {
          if (next != null) {
            _handleJump(next);
            ref.read(searchJumpProvider.notifier).clear();
          }
        });

        final async = ref.watch(loader);
        final ui =
            ref.watch(settingsControllerProvider).value ?? const UiSettings();
        final minify = ui.minifyOnCopy;

        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 44,
            titleSpacing: 16,
            title: Row(
              children: [
                const Expanded(child: InlineProgressBar()),
                async.maybeWhen(
                  data: (res) => IconButton(
                    tooltip: 'Copy all',
                    icon: const Icon(Icons.copy_all),
                    onPressed: () async {
                      final txt = _wrapAll(res.pieces, minified: minify);
                      await Clipboard.setData(ClipboardData(text: txt));
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            minify ? 'All minified & copied' : 'All copied',
                          ),
                        ),
                      );
                    },
                  ),
                  orElse: () => const SizedBox.shrink(),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
          body: async.when(
            data: (res) {
              final pieces = res.pieces;
              _pieces = pieces;
              if (pieces.isEmpty) {
                return const Center(
                  child: Text('No files (too large or not found)'),
                );
              }
              for (final p in pieces) {
                _getControllerFor(p);
                _getKeyFor(p.path);
              }
              return ListView.builder(
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
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
          ),
        );
      },
    );
  }
}
