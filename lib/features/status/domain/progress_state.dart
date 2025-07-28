class ProgressState {
  final int value; // 0..100
  final String message; // "Scanning Project", "Filtering" ...
  final StatusLevel level; // PASS/WARN/FAIL/INFO

  const ProgressState({
    this.value = 0,
    this.message = 'Ready',
    this.level = StatusLevel.pass,
  });

  ProgressState copyWith({int? value, String? message, StatusLevel? level}) =>
      ProgressState(
        value: value ?? this.value,
        message: message ?? this.message,
        level: level ?? this.level,
      );
}

enum StatusLevel { fail, warn, info, pass }
