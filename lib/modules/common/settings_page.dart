import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/account_section.dart';
import 'widgets/appearance_section.dart';
import 'widgets/cache_and_update_section.dart';
import 'widgets/about_section.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('设置')),
      body: ListView(
        children: [
          const AccountSection(),
          const Divider(),
          const AppearanceSection(),
          const Divider(),
          const CacheAndUpdateSection(),
          const Divider(),
          const AboutSection(),
        ],
      ),
    );
  }
}
