import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/settings_controller.dart';
import '../infrastructure/settings_store.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  final _tokenCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    SettingsStore().readGithubToken().then((v) {
      _tokenCtrl.text = v ?? '';
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _tokenCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ui =
        ref.watch(settingsControllerProvider).value ?? const UiSettings();
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('GitHub token'),
          const SizedBox(height: 8),
          TextField(
            controller: _tokenCtrl,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'ghp_xxx… (optional)',
            ),
            obscureText: true,
          ),
          const SizedBox(height: 8),
          FilledButton(
            onPressed: () async {
              await SettingsStore().saveGithubToken(_tokenCtrl.text.trim());
              if (!context.mounted) return;
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Token saved')));
            },
            child: const Text('Save token'),
          ),
          const Divider(height: 32),

          const Text('Copy'),
          const SizedBox(height: 8),
          SwitchListTile(
            title: const Text('Minify content on copy'),
            value: ui.minifyOnCopy,
            onChanged: (v) => ref
                .read(settingsControllerProvider.notifier)
                .setMinifyOnCopy(v),
          ),

          const Divider(height: 32),

          const Text('Editor UI'),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: ui.fontName,
            items: const [
              'FantasqueSansM Nerd Font Mono',
              'Cascadia Code',
              'Consolas',
              'Courier',
              'monospace',
            ].map((n) => DropdownMenuItem(value: n, child: Text(n))).toList(),
            onChanged: (v) {
              if (v != null) {
                ref.read(settingsControllerProvider.notifier).setFontName(v);
              }
            },
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          const SizedBox(height: 12),
          Slider(
            min: 9,
            max: 27,
            divisions: 18,
            value: ui.fontSize,
            label: ui.fontSize.toStringAsFixed(0),
            onChanged: (v) =>
                ref.read(settingsControllerProvider.notifier).setFontSize(v),
          ),
        ],
      ),
    );
  }
}
