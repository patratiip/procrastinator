// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:procrastinator/src/features/settings/di/settings_scope.dart';
import 'package:procrastinator/src/features/settings/bloc/app_settings_bloc.dart';
import 'package:procrastinator/src/ui_kit/color/color_scheme_my.dart';

/// {@template language_option_widget}
/// Widget that shows [LanguageOptionWidget]
/// {@endtemplate}
class LanguageOptionWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String languageCode;
  final Widget? leadingWidget;
  final bool? newFeature;

  const LanguageOptionWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.languageCode,
    this.leadingWidget,
    this.newFeature,
  });

  /// {@macro language_option_widget}

  @override
  Widget build(BuildContext context) {
    final appSettings = SettingsScope.settingsOf(context);
    final actualLanguage = Localizations.localeOf(context).languageCode;

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
                  // Country flag
                  Expanded(
                    flex: 1,
                    child: leadingWidget ?? const SizedBox.shrink(),
                  ),
                  const SizedBox(width: 12),

                  // Language name
                  Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            subtitle,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      )),

                  // New or not
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
                  const SizedBox(width: 12),

                  // Is that actual language
                  actualLanguage == languageCode
                      ? const Icon(
                          Icons.done_rounded,
                          size: 32,
                          color: MyAppColorScheme.primary,
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(width: 12),
                ]),
          ),
        ),
      ),
    );
  }
}
