import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart' as fh;

import '../../../../core/utils/minify.dart';
import '../../domain/content_piece.dart';
import '../../../settings/application/settings_controller.dart';

class FilePanel extends ConsumerStatefulWidget {
  final ContentPiece piece;
  final CodeController controller;

  /// Если true — FilePanel сам dispose'ит контроллер.
  /// В нашем случае контроллер предоставляется родителем и живёт дольше карточки.
  final bool controllerOwned;

  const FilePanel({
    super.key,
    required this.piece,
    required this.controller,
    this.controllerOwned = false,
  });

  @override
  FilePanelState createState() => FilePanelState();
}

class FilePanelState extends ConsumerState<FilePanel>
    with AutomaticKeepAliveClientMixin {
  bool _collapsed = false;

  // Поиск
  int _currentHit = 0;
  final _hits = <int>[];
  String _query = '';

  CodeController get _controller => widget.controller;

  @override
  void dispose() {
    if (widget.controllerOwned) {
      _controller.dispose();
    }
    super.dispose();
  }

  // API для внешнего прыжка из EditorsPane.
  void jumpToQuery(String q) {
    if (q.isEmpty) return;
    if (_query != q) {
      _query = q;
      _rebuildHits(q);
    }
    if (_hits.isNotEmpty) {
      _goToHit(0, _query);
      setState(() {
        _collapsed = false; // раскрыть при прыжке
      });
    }
  }

  String _wrapForCopy(String text) => '```${widget.piece.path}\n$text\n```';

  Future<void> _copy({required bool minified}) async {
    final text = minifyContentIfNeeded(_controller.text, minified);
    final wrapped = _wrapForCopy(text);
    await Clipboard.setData(ClipboardData(text: wrapped));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(minified ? 'Minified copied' : 'Copied')),
    );
  }

  String minifyContentIfNeeded(String text, bool minified) =>
      minified ? minifyContent(text) : text;

  /// Более точная оценка ширины «желоба» с номерами строк.
  double _gutterWidth(TextStyle style) {
    double measure(String s) {
      final tp = TextPainter(
        text: TextSpan(text: s, style: style),
        textDirection: TextDirection.ltr,
      )..layout();
      return tp.width;
    }

    final lines = '\n'.allMatches(_controller.text).length + 1;
    final digits = lines.toString().length;
    double maxDigitW = 0;
    for (var d = 0; d <= 9; d++) {
      maxDigitW = math.max(maxDigitW, measure('$d'));
    }
    final content = maxDigitW * digits;
    final dividerPad = maxDigitW;
    final leftPad = maxDigitW * 0.5;
    final total = content + dividerPad + leftPad;
    return total.ceilToDouble();
  }

  void _rebuildHits(String q) {
    _hits.clear();
    _currentHit = 0;
    if (q.isEmpty) return;
    final text = _controller.text;
    var idx = 0;
    while (true) {
      idx = text.indexOf(q, idx);
      if (idx < 0) break;
      _hits.add(idx);
      idx += q.length;
    }
  }

  void _goToHit(int i, String q) {
    if (_hits.isEmpty) return;
    _currentHit = (i % _hits.length + _hits.length) % _hits.length;
    final start = _hits[_currentHit];
    final end = start + q.length;
    _controller.selection = TextSelection(baseOffset: start, extentOffset: end);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ui =
        ref.watch(settingsControllerProvider).value ?? const UiSettings();
    final minify = ui.minifyOnCopy;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            // header
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.piece.path,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  tooltip: _collapsed ? 'Expand' : 'Collapse',
                  onPressed: () => setState(() => _collapsed = !_collapsed),
                  icon: Icon(
                    _collapsed ? Icons.unfold_more : Icons.unfold_less,
                  ),
                ),
                IconButton(
                  tooltip: 'Copy',
                  onPressed: () => _copy(minified: minify),
                  icon: const Icon(Icons.copy_all),
                ),
              ],
            ),
            // search
            AnimatedSize(
              duration: const Duration(milliseconds: 180),
              alignment: Alignment.topCenter,
              child: _collapsed
                  ? const SizedBox.shrink()
                  : Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: const InputDecoration(
                                  isDense: true,
                                  hintText: 'Search in file…',
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (v) {
                                  _query = v;
                                  _rebuildHits(v);
                                  setState(() {});
                                },
                                onSubmitted: (v) {
                                  _query = v;
                                  _rebuildHits(v);
                                  _goToHit(0, v);
                                  setState(() {});
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${_hits.isEmpty ? 0 : _currentHit + 1}/${_hits.length}',
                            ),
                            IconButton(
                              tooltip: 'Prev',
                              onPressed: _hits.isEmpty
                                  ? null
                                  : () => setState(
                                      () => _goToHit(_currentHit - 1, _query),
                                    ),
                              icon: const Icon(Icons.keyboard_arrow_up),
                            ),
                            IconButton(
                              tooltip: 'Next',
                              onPressed: _hits.isEmpty
                                  ? null
                                  : () => setState(
                                      () => _goToHit(_currentHit + 1, _query),
                                    ),
                              icon: const Icon(Icons.keyboard_arrow_down),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // editor
                        SizedBox(
                          height: 420,
                          child: CodeTheme(
                            data: CodeThemeData(styles: fh.atomOneDarkTheme),
                            child: CodeField(
                              controller: _controller,
                              textStyle: TextStyle(
                                fontFamily: ui.fontName,
                                fontSize: ui.fontSize,
                              ),
                              expands: true,
                              gutterStyle: GutterStyle(
                                width: _gutterWidth(
                                  TextStyle(
                                    fontFamily: ui.fontName,
                                    fontSize: ui.fontSize,
                                  ),
                                ),
                                textAlign: TextAlign.right,
                              ),
                              // tabSpaces: ui.tabSize, // если поддерживается пакетом
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
