import 'dart:convert';
import 'package:http/http.dart' as http;

/// Очень тонкий клиент GitHub API.
/// Главное: всегда отправляем корректный `User-Agent`,
/// иначе GitHub может отклонять запросы.
class GithubClient {
  final http.Client _client;
  final String? token;

  /// Можно пробросить свой http.Client (например, для тестов)
  GithubClient({http.Client? client, this.token})
    : _client = client ?? http.Client();

  Map<String, String> _apiHeaders() {
    final headers = <String, String>{
      // Требуется GitHub: валидный User-Agent
      // https://docs.github.com/en/rest/using-the-rest-api/troubleshooting-the-rest-api#user-agent-required
      'User-Agent': 'flutter-suction',
      'Accept': 'application/vnd.github+json',
      'X-GitHub-Api-Version': '2022-11-28',
    };
    final t = token;
    if (t != null && t.isNotEmpty) {
      headers['Authorization'] = 'Bearer $t';
    }
    return headers;
  }

  Future<Map<String, dynamic>> getJson(Uri url) async {
    final resp = await _client.get(url, headers: _apiHeaders());
    if (resp.statusCode < 200 || resp.statusCode >= 300) {
      throw Exception('GitHub error ${resp.statusCode}: ${resp.body}');
    }
    return json.decode(resp.body) as Map<String, dynamic>;
  }

  /// Чтение сырого файла с raw.githubusercontent.com.
  /// Токен туда не прикручиваем (он и не сработает), но `User-Agent` оставим —
  /// это не мешает.
  Future<String> getText(Uri url) async {
    final resp = await _client.get(
      url,
      headers: const {'User-Agent': 'flutter-suction'},
    );
    if (resp.statusCode < 200 || resp.statusCode >= 300) {
      throw Exception('GitHub raw error ${resp.statusCode}');
    }
    return resp.body;
  }

  void close() => _client.close();
}
