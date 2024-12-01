import 'package:flutter/material.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/features/ui_kit/back_appbar_arrow.dart';
import 'package:procrastinator/src/shared/view/widgets/theme_option_widget.dart';
import 'package:settings_repository/settings_repository.dart';

/// {@template theme_settings_screen}
/// Widget that shows [ThemeSettingsScreen]
/// {@endtemplate}
class ThemeSettingsScreen extends StatelessWidget {
  const ThemeSettingsScreen({super.key});

  /// {@macro theme_settings_screen}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.of(context).settingsOptionAppTheme),
        leading: const BackAppbarArrow(),
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(right: 16, left: 16, top: 24, bottom: 44),
        primary: true,
        child: Column(
          children: [
            // Light
            ThemeOptionWidget(
              title: Localization.of(context).appThemeTitleLight,
              theme: AppTheme(
                  themeMode: ThemeMode.light, seed: MyAppColorScheme.primary),
              leadingWidget: const Text(
                '🔆',
                style: TextStyle(fontSize: 22),
              ),
            ),

            // Dark
            ThemeOptionWidget(
              title: Localization.of(context).appThemeTitleDark,
              theme: AppTheme(
                  themeMode: ThemeMode.dark, seed: MyAppColorScheme.primary),
              leadingWidget: const Text(
                '🌙',
                style: TextStyle(fontSize: 22),
              ),
            ),

            // Default
            ThemeOptionWidget(
              title: Localization.of(context).appThemeTitleDefault,
              theme: AppTheme.defaultTheme,
              leadingWidget: const Text(
                '⚙️',
                style: TextStyle(fontSize: 22),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
