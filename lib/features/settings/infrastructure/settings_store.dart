import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SettingsStore {
  static const _keyToken = 'github_token';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveGithubToken(String token) =>
      _storage.write(key: _keyToken, value: token);

  Future<String?> readGithubToken() => _storage.read(key: _keyToken);
}
