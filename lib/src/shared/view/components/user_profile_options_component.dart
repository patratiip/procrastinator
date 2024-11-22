import 'package:flutter/material.dart';
import 'package:procrastinator/src/core/styles/styles.dart';

class UserProfilePageFeatureCardComponent extends StatefulWidget {
  final String title;
  final bool? newFeature;

  const UserProfilePageFeatureCardComponent(
      {super.key, required this.title, this.newFeature});

  @override
  State<UserProfilePageFeatureCardComponent> createState() =>
      _UserProfilePageFeatureCardComponentState();
}

class _UserProfilePageFeatureCardComponentState
    extends State<UserProfilePageFeatureCardComponent> {
  void _goGo() {
    // Navigator.of(context).pushNamed(MainNavigationRoutes.profileSecondary);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: _goGo,
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
                        widget.title,
                        style: const TextStyle(fontSize: 22),
                      )),
                  if (widget.newFeature == true)
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
