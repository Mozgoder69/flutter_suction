import 'dart:convert';
import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:path_provider/path_provider.dart';

part 'settings_controller.g.dart';

class UiSettings {
  final String fontName;
  final double fontSize;
  final bool minifyOnCopy;

  const UiSettings({
    this.fontName = 'monospace',
    this.fontSize = 12,
    this.minifyOnCopy = true,
  });

  UiSettings copyWith({
    String? fontName,
    double? fontSize,
    bool? minifyOnCopy,
  }) => UiSettings(
    fontName: fontName ?? this.fontName,
    fontSize: fontSize ?? this.fontSize,
    minifyOnCopy: minifyOnCopy ?? this.minifyOnCopy,
  );

  Map<String, dynamic> toJson() => {
    'fontName': fontName,
    'fontSize': fontSize,
    'minifyOnCopy': minifyOnCopy,
  };

  factory UiSettings.fromJson(Map<String, dynamic> json) => UiSettings(
    fontName: json['fontName'] as String? ?? 'monospace',
    fontSize: (json['fontSize'] as num?)?.toDouble() ?? 12,
    minifyOnCopy: json['minifyOnCopy'] as bool? ?? true,
  );
}

@riverpod
class SettingsController extends _$SettingsController {
  @override
  Future<UiSettings> build() async {
    final f = await _file();
    if (!await f.exists()) return const UiSettings();
    final txt = await f.readAsString();
    if (txt.trim().isEmpty) return const UiSettings();
    return UiSettings.fromJson(json.decode(txt) as Map<String, dynamic>);
  }

  Future<File> _file() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/ui_settings.json');
  }

  Future<void> _save(UiSettings s) async {
    final f = await _file();
    await f.writeAsString(json.encode(s.toJson()));
  }

  Future<void> setFontName(String name) async {
    final s = await future;
    final ns = s.copyWith(fontName: name);
    state = AsyncData(ns);
    await _save(ns);
  }

  Future<void> setFontSize(double size) async {
    final s = await future;
    final ns = s.copyWith(fontSize: size);
    state = AsyncData(ns);
    await _save(ns);
  }

  Future<void> setMinifyOnCopy(bool v) async {
    final s = await future;
    final ns = s.copyWith(minifyOnCopy: v);
    state = AsyncData(ns);
    await _save(ns);
  }
}
