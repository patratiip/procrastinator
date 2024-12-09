// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/features/student_app/features/lection_plan/model/lection.dart';
import 'package:procrastinator/src/shared/resources/resources.dart';
import 'package:procrastinator/src/ui_kit/color/color_scheme_my.dart';

/// {@template lection_bottom_sheet_widget}
/// Shows [Lection] details in BottomScheet.
/// {@endtemplate}
/// {@macro lection_bottom_sheet_widget}
class LectionBottomSheetWidget extends StatelessWidget {
  final Lection lection;
  const LectionBottomSheetWidget({super.key, required this.lection});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd.MM.yy');

    return Container(
      height: 400,
      constraints: const BoxConstraints(maxWidth: 600),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 12,
            left: 16,
            right: 16,
            bottom: 44,
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  // Swiper
                  Container(
                    height: 5,
                    width: 60,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSurface,
                        borderRadius: BorderRadius.circular(8)),
                  ),

                  // Header
                  Text(
                    Localization.of(context).lectionInfoHeader,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Column(
                children: [
                  // Lection theme
                  Container(
                      width: 200,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 137, 232, 135),
                          border: Border.all(
                              width: 1, color: MyAppColorScheme.secondary),
                          borderRadius: BorderRadius.circular(8)),
                      child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                lection.theme,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: Colors.white),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                              ),
                            )
                          ])),
                  const SizedBox(height: 16),

                  // Trainer Image
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      width: 100,
                      height: 100,
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        image: DecorationImage(
                          image: AssetImage(Images.lutzLogotypePng),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Trainer name
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      lection.trainer.length > 10
                          ? '${lection.trainer.substring(0, 10)}...'
                          : lection.trainer,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),

                  // Date, day of week
                  Text(
                    '${dateFormat.format(lection.date)},${lection.dayOfWeek.length > 2 ? lection.dayOfWeek.substring(0, 2) : lection.dayOfWeek}',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}