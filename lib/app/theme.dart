import 'package:flutter/material.dart';

ThemeData buildTheme() {
  const back = Color(0xFF182028);
  const text = Color(0xFFDDEEFF);

  final base = ThemeData.dark(useMaterial3: true); // <-- передаём здесь

  return base.copyWith(
    scaffoldBackgroundColor: back,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF4444CC),
      brightness: Brightness.dark,
    ),
    textTheme: const TextTheme(bodyMedium: TextStyle(color: text)),
  );
}
