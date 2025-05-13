import 'package:expense_tracker_sqflite_provider/Providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  static const name = "settings_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Consumer<ThemeProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 2,
              child: SwitchListTile.adaptive(
                title: Text(
                  "Dark Mode",
                  style: TextStyle(
                    color: context.read<ThemeProvider>().getTextColor(context),
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  "Change theme mode here",
                  style: TextStyle(
                    color: context.read<ThemeProvider>().getTextColor(context),
                    fontSize: 14,
                  ),
                ),
                value: provider.getThemeValue(),
                onChanged: (value) {
                  provider.updateTheme(value: value);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
