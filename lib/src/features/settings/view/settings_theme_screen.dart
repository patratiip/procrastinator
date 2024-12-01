import 'package:flutter/material.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/shared/view/widgets/language_option_widget.dart';
import 'package:procrastinator/src/shared/view/widgets/theme_option_widget.dart';

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(right: 16, left: 16, top: 24, bottom: 44),
        primary: true,
        child: Column(
          children: [
            // English
            ThemeOptionWidget(
              title: Localization.of(context).languagesEnglish,
              languageCode: 'en',
              leadingWidget: const Text(
                '🇬🇧',
                style: TextStyle(fontSize: 22),
              ),
            ),

            // German
            ThemeOptionWidget(
              title: Localization.of(context).languagesGerman,
              languageCode: 'de',
              leadingWidget: const Text(
                '🇩🇪',
                style: TextStyle(fontSize: 22),
              ),
            ),

            // Russian
            ThemeOptionWidget(
              title: Localization.of(context).languagesRussian,
              languageCode: 'ru',
              leadingWidget: const Text(
                '🇷🇺',
                style: TextStyle(fontSize: 22),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
