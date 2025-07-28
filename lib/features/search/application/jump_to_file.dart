import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Команда глобального перехода к файлу и поисковому запросу в нём.
class JumpCommand {
  final String path;
  final String query;
  const JumpCommand(this.path, this.query);
}

/// Хранилище последней команды перехода.
class JumpNotifier extends Notifier<JumpCommand?> {
  @override
  JumpCommand? build() => null;

  void set(JumpCommand cmd) => state = cmd;
  void clear() => state = null;
}

final searchJumpProvider = NotifierProvider<JumpNotifier, JumpCommand?>(
  JumpNotifier.new,
);
