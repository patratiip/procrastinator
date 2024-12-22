import 'package:flutter/material.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/platform/settings/widget/settings_language_screen.dart';
import 'package:procrastinator/src/platform/settings/widget/settings_theme_screen.dart';
import 'package:procrastinator/src/ui_kit/widget/back_appbar_arrow.dart';
import 'package:procrastinator/src/ui_kit/widget/feature_card_component.dart';

/// {@template settings_screen}
/// Widget that shows [SettingsScreen]
/// {@endtemplate}
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  /// {@macro settings_screen}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.of(context).settingsLabelText),
        leading: const BackAppbarArrow(),
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(right: 16, left: 16, top: 24, bottom: 44),
        primary: true,
        child: Center(
          child: Column(
            children: [
              // App Language
              FeatureCardComponent(
                title: Localization.of(context).settingsOptionLanguage,
                route: const LanguageSettingsScreen(),
              ),

              // App Theme
              FeatureCardComponent(
                title: Localization.of(context).settingsOptionAppTheme,
                route: const ThemeSettingsScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
