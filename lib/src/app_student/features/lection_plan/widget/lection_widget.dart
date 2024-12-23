import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:procrastinator/src/app_student/features/lection_plan/model/lection.dart';
import 'package:procrastinator/src/ui_kit/color/color_scheme_my.dart';
import 'package:procrastinator/assets/resources.dart';
import 'package:procrastinator/src/ui_kit/widget/card_widget.dart';

/// {@template lection_widget}
/// Shows [LectionWidget].
/// {@endtemplate}

class LectionWidget extends StatelessWidget {
  final double? height;
  final Lection lection;
  final bool tappable;
  final VoidCallback? onTap;

  /// {@macro lection_widget}
  const LectionWidget({
    super.key,
    required this.lection,
    this.height,
    this.tappable = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd.MM.yy');

    return CardWidget(
      tappable: tappable,
      onTap: onTap,
      height: height ?? 80,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Lection theme
            Expanded(
              flex: 3,
              child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 137, 232, 135),
                      border: Border.all(
                          width: 1, color: MyAppColorScheme.secondary),
                      borderRadius: BorderRadius.circular(8)),
                  child:
                      Stack(alignment: AlignmentDirectional.center, children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        lection.theme,
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                    )
                  ])),
            ),

            // Trainer Image
            Expanded(
              flex: 2,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  width: 44,
                  height: 44,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(22)),
                    image: DecorationImage(
                      image: AssetImage(Images.lutzLogotypePng),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),

            // Trainer name
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  lection.trainer.length > 10
                      ? '${lection.trainer.substring(0, 10)}...'
                      : lection.trainer,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),

            // Date, day of week
            Text(
                '${dateFormat.format(lection.date)},${lection.dayOfWeek.length > 2 ? lection.dayOfWeek.substring(0, 2) : lection.dayOfWeek}'),
          ]),
    );
  }
}
