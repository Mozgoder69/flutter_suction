import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/progress_controller.dart';
import '../domain/progress_state.dart';

/// Строка статуса + полоса под ней
class InlineProgressBar extends ConsumerWidget implements PreferredSizeWidget {
  const InlineProgressBar({Key? key}) : super(key: key);

  Color _colorOf(StatusLevel lvl, ColorScheme scheme) {
    return switch (lvl) {
      StatusLevel.fail => scheme.error,
      StatusLevel.warn => Colors.amber,
      StatusLevel.info => scheme.primary,
      StatusLevel.pass => scheme.secondary,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final st = ref.watch(progressControllerProvider);
    final color = _colorOf(st.level, Theme.of(context).colorScheme);

    final pct = st.value.clamp(0, 100);
    final pctText = pct <= 0 ? '—%' : '$pct%';
    final text = '${st.message}: $pctText';

    return Row(
      children: [
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        const SizedBox(width: 8),
        // компактная полоса в одну линию
        SizedBox(
          width: 100,
          height: 6,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            child: LinearProgressIndicator(
              value: pct >= 100 ? 1 : (pct <= 0 ? null : pct / 100),
              backgroundColor: color.withOpacity(0.15),
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(24);
}

/// Простая полоса без текста
class GlobalProgressBar extends ConsumerWidget implements PreferredSizeWidget {
  const GlobalProgressBar({Key? key}) : super(key: key);

  Color _colorOf(StatusLevel lvl, ColorScheme scheme) {
    return switch (lvl) {
      StatusLevel.fail => scheme.error,
      StatusLevel.warn => Colors.amber,
      StatusLevel.info => scheme.primary,
      StatusLevel.pass => scheme.secondary,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final st = ref.watch(progressControllerProvider);
    final color = _colorOf(st.level, Theme.of(context).colorScheme);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        child: LinearProgressIndicator(
          value: st.value >= 100 ? 1 : (st.value <= 0 ? null : st.value / 100),
          backgroundColor: color.withOpacity(0.15),
          valueColor: AlwaysStoppedAnimation(color),
          minHeight: 6,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(6);
}
