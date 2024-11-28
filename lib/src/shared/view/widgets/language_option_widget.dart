import 'package:flutter/material.dart';
import 'package:procrastinator/src/core/di/scopes/settings_scope.dart';
import 'package:procrastinator/src/core/styles/styles.dart';
import 'package:procrastinator/src/features/settings/bloc/app_settings_bloc.dart';

/// {@template language_option_widget}
/// Widget that shows [LanguageOptionWidget]
/// {@endtemplate}
class LanguageOptionWidget extends StatelessWidget {
  final String title;
  final String languageCode;
  final String countryFlag;
  final bool? newFeature;

  const LanguageOptionWidget({
    super.key,
    required this.title,
    required this.languageCode,
    required this.countryFlag,
    this.newFeature,
  });

  /// {@macro language_option_widget}

  @override
  Widget build(BuildContext context) {
    final appSettings = SettingsScope.settingsOf(context);
    final actualLanguage =
        SettingsScope.settingsOf(context).locale!.languageCode;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            SettingsScope.blocOf(context)
                .add(AppSettingsEvent.updateAppSettings(
              appSettings: appSettings.copyWith(locale: Locale(languageCode)),
            ));
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(vertical: 8),
            constraints: const BoxConstraints(maxWidth: 600),
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      flex: 1,
                      child: Text(
                        countryFlag,
                        style: const TextStyle(fontSize: 22),
                      )),
                  Expanded(
                      flex: 6,
                      child: Text(
                        title,
                        style: const TextStyle(fontSize: 22),
                      )),
                  if (newFeature == true)
                    Expanded(
                      flex: 1,
                      child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 137, 232, 135),
                              border: Border.all(
                                  width: 1, color: MyAppColorScheme.secondary),
                              borderRadius: BorderRadius.circular(8)),
                          child: const Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Text(
                                  'new',
                                  style: TextStyle(color: Colors.white),
                                  maxLines: 1,
                                )
                              ])),
                    ),
                  actualLanguage == languageCode
                      ? const Icon(
                          Icons.done,
                          size: 24,
                          color: MyAppColorScheme.primary,
                        )
                      : const SizedBox.shrink()
                ]),
          ),
        ),
      ),
    );
  }
}
