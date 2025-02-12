// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:procrastinator/src/platform/initialization/model/app_theme.dart';
import 'package:procrastinator/src/platform/settings/bloc/app_settings_bloc.dart';
import 'package:procrastinator/src/platform/settings/di/settings_scope.dart';
import 'package:procrastinator/src/ui_kit/color/color_scheme_my.dart';

/// {@template theme_option_widget}
/// Widget that shows [ThemeOptionWidget]
/// {@endtemplate}
class ThemeOptionWidget extends StatelessWidget {
  final String title;
  final AppTheme theme;
  final Widget? leadingWidget;
  final bool? newFeature;

  /// {@macro theme_option_widget}
  const ThemeOptionWidget({
    super.key,
    required this.title,
    required this.theme,
    this.leadingWidget,
    this.newFeature,
  });

  /// {@macro theme_option_widget}

  @override
  Widget build(BuildContext context) {
    final appSettings = SettingsScope.settingsOf(context);
    final actualThemeMode =
        appSettings.appTheme?.themeMode ?? AppTheme.defaultTheme.themeMode;

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
              appSettings: appSettings.copyWith(appTheme: theme),
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
                children: [
                  Expanded(
                    flex: 1,
                    child: leadingWidget ?? const SizedBox.shrink(),
                  ),
                  Expanded(
                      flex: 6,
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.headlineSmall,
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
                          child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Text(
                                  'new',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(color: Colors.white),
                                  maxLines: 1,
                                )
                              ])),
                    ),
                  actualThemeMode == theme.themeMode
                      ? const Icon(
                          Icons.done,
                          size: 32,
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
