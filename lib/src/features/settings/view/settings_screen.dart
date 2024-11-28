import 'package:flutter/material.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/shared/view/widgets/feature_card_component.dart';
import 'package:procrastinator/src/shared/view/widgets/language_option_widget.dart';

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
            // App Language
            FeatureCardComponent(
              title: Localization.of(context).settingsOptionLanguage,
              route: const LanguageSettingsScreen(),
            ),
          ],
        ),
      ),
    );
  }
}

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
              languageCode: 'en',
              countryFlag: '🇬🇧',
            ),

            // German
            LanguageOptionWidget(
              title: Localization.of(context).languagesGerman,
              languageCode: 'de',
              countryFlag: '🇩🇪',
            ),

            // Russian
            LanguageOptionWidget(
              title: Localization.of(context).languagesRussian,
              languageCode: 'ru',
              countryFlag: '🇷🇺',
            ),
          ],
        ),
      ),
    );
  }
}
