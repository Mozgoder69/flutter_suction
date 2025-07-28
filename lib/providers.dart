import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/settings/infrastructure/settings_store.dart';

/// Хранилище защищённых настроек (GitHub token и т.д.)
final settingsStoreProvider = Provider<SettingsStore>((_) => SettingsStore());
