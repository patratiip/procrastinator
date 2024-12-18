import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/ui_kit/color/color_scheme_my.dart';
import 'package:procrastinator/src/features/student_app/features/entry_adding/bloc/entry_adding_bloc/entry_adding_bloc.dart';
import 'package:procrastinator/src/ui_kit/widget/my_circular_progress.dart';

/// {@template entry_adding_button}
/// Widget that shows [EntryAddingButton] in [CalendarEntryAddingWidget]
///{@endtemplate}
class EntryAddingButton extends StatelessWidget {
  /// {@macro entry_adding_button}
  const EntryAddingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EntryAddingBloc, EntryAddingState>(
      builder: (context, state) {
        // Button is enabled
        if (state.isValid) {
          return _EntryAddingButtonBody(
            child: Text(
              Localization.of(context).addEntryButtonText,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                  ),
            ),
            onTap: () {
              final bloc = BlocProvider.of<EntryAddingBloc>(context);
              bloc.add(const EntryAddingEvent.add());
            },
          );

          // Button is in Progress
        } else if (state.validating) {
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
      },
    );
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
