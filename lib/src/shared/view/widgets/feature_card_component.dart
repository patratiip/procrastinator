import 'package:flutter/material.dart';
import 'package:procrastinator/src/core/styles/styles.dart';
import 'package:procrastinator/src/shared/view/pages/page_with_error.dart';

/// {@template feature_card_component}
/// Widget that shows [FeatureCardComponent]
/// {@endtemplate}
class FeatureCardComponent extends StatelessWidget {
  final String title;

  //TODO Add date and calculate new or not
  // final DateTime dateOfAdiing;
  final bool? newFeature;
  final Widget? route;

  const FeatureCardComponent(
      {super.key, required this.title, this.newFeature, this.route});

  /// {@macro feature_card_component}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.of(context).push<void>(MaterialPageRoute<void>(
              builder: (BuildContext context) => route ?? const PageWithError(),
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
                      flex: 3,
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
                  const Icon(
                    Icons.chevron_right_rounded,
                    size: 40,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
