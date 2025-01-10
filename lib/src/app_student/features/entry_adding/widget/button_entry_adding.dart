import 'package:animated_icon/animated_icon.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:procrastinator/main.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/actions_redux/ACTION_add_entry.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/data/entry_adding_repository.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/core/utils/extensions/context_extension.dart';
import 'package:procrastinator/src/ui_kit/color/color_scheme_my.dart';
import 'package:procrastinator/src/ui_kit/widget/my_circular_progress.dart';

/// {@template entry_adding_button}
/// Widget that shows [EntryAddingButton] in [CalendarEntryAddingWidget]
///{@endtemplate}
class EntryAddingButton extends StatelessWidget {
  /// {@macro entry_adding_button}
  const EntryAddingButton({super.key});

  @override
  Widget build(BuildContext context) {
    // Feture Redux state
    final state = context.state.reduxEntryAddingState;
    // Button is enabled
    if (state.isValid) {
      return _EntryAddingButtonBody(
        child: Text(
          Localization.of(context).addEntryButtonText,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.white,
              ),
        ),
        onTap: () async {
          final entryAddingActionStatus = await context.dispatch(AddEntryAction(
              entryAddingRepository: getIt<IEntryAddingRepository>()));

          // Hide snackBars and show new one on successfully [Entry] adding
          if (entryAddingActionStatus.isCompletedOk) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 5),
                  elevation: 40,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: MyAppColorScheme.sucsessColor,
                  content: Container(
                    width: double.infinity,
                    height: 38,
                    decoration: const BoxDecoration(
                        color: MyAppColorScheme.sucsessColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: AnimateIcon(
                              key: UniqueKey(),
                              onTap: () {},
                              iconType: IconType.continueAnimation,
                              height: 50,
                              width: 50,
                              color: Colors.white,
                              animateIcon: AnimateIcons.upload),
                        ),
                        Text(
                            Localization.of(context)
                                .entrySuccessfulAddedCalendarMessage,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              );
            });
          }
        },
      );

      //TODO: Don't works. Need to ask Mark of Philip about that shit...
      // Button is in Progress
    } else if (context.isWaiting(AddEntryAction)) {
      return const _EntryAddingButtonBody(
          child: MyCircularProgress(
        color: Colors.white,
      ));

      // Button is disabled
    } else {
      return _EntryAddingButtonBody(
        color: Colors.grey,
        child: Text(
          Localization.of(context).addEntryButtonText,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.white,
                //fontWeight: FontWeight.w500
              ),
        ),
      );
    }
  }
}

/// {@template _entry_adding_button_body}
/// [_EntryAddingButtonBody] is a body widget for [EntryAddingButton].
/// {@endtemplate}

class _EntryAddingButtonBody extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color? color;

  /// {@macro _entry_adding_button_body}
  const _EntryAddingButtonBody({
    super.key,
    required this.child,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  WidgetStatePropertyAll(color ?? MyAppColorScheme.primary),
              shape: const WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))))),
          onPressed: onTap ?? () {},
          child: child),
    );
  }
}
