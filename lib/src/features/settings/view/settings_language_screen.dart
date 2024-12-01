import 'package:flutter/material.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/shared/view/widgets/language_option_widget.dart';

/// {@template language_settings_screen}
/// Widget that shows [LanguageSettingsScreen]
/// {@endtemplate}
class LanguageSettingsScreen extends StatelessWidget {
  const LanguageSettingsScreen({super.key});

  /// {@macro language_settings_screen}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.of(context).settingsOptionLanguage),
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
            LanguageOptionWidget(
              title: Localization.of(context).languagesEnglish,
              subtitle: 'English',
              languageCode: 'en',
              leadingWidget: const Text(
                '🇬🇧',
                style: TextStyle(fontSize: 32),
              ),
            ),

            // German
            LanguageOptionWidget(
              title: Localization.of(context).languagesGerman,
              subtitle: 'Deuthsch',
              languageCode: 'de',
              leadingWidget: const Text(
                '🇩🇪',
                style: TextStyle(fontSize: 32),
              ),
            ),

            // Russian
            LanguageOptionWidget(
              title: Localization.of(context).languagesRussian,
              subtitle: 'Русский',
              languageCode: 'ru',
              leadingWidget: const Text(
                '🇷🇺',
                style: TextStyle(fontSize: 32),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
