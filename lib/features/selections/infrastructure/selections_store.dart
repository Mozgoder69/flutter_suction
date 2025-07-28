import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import '../../settings/domain/app_settings.dart';
import '../domain/selection_model.dart';

class SelectionsStore {
  Future<File> _file() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = p.join(dir.path, AppSettings.selectionsFile);
    return File(path);
  }

  Future<Map<String, Map<String, dynamic>>> _loadAll() async {
    final f = await _file();
    if (!await f.exists()) return {};
    final txt = await f.readAsString();
    if (txt.trim().isEmpty) return {};
    final data = json.decode(txt) as Map<String, dynamic>;
    return data.map((k, v) => MapEntry(k, (v as Map<String, dynamic>)));
  }

  Future<void> saveSelection(SelectionModel s) async {
    final all = await _loadAll();
    final current = all[s.project] ?? {};
    current.addAll(s.toJson());
    all[s.project] = current;
    final f = await _file();
    await f.writeAsString(
      const JsonEncoder.withIndent('  ').convert(all),
      flush: true,
    );
  }

  Future<SelectionModel?> loadSelection(String project) async {
    final all = await _loadAll();
    final data = all[project];
    if (data == null) return null;
    return SelectionModel.fromJson(data);
  }

  Future<List<String>> listProjects() async {
    final all = await _loadAll();
    return all.keys.toList()..sort();
  }
}
