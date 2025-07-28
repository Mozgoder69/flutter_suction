import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'progress_controller.dart';
import '../domain/progress_state.dart';

void reportResult(
  WidgetRef ref,
  BuildContext context, {
  required String message,
  StatusLevel level = StatusLevel.pass,
}) {
  ref.read(progressControllerProvider.notifier).setLevel(level);
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
