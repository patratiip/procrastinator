import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:procrastinator/src/core/router/main_navigation.dart';

import '../../../../core/styles/color_scheme_my.dart';

class UserProfilePageOptionsCardComponent extends StatefulWidget {
  final String title;

  UserProfilePageOptionsCardComponent({super.key, required this.title});

  @override
  State<UserProfilePageOptionsCardComponent> createState() =>
      _UserProfilePageOptionsCardComponentState();
}

class _UserProfilePageOptionsCardComponentState
    extends State<UserProfilePageOptionsCardComponent> {
  var dateFormat = DateFormat('dd.MM.yy');

  void _goGo() {
    // Navigator.of(context).pushNamed(MainNavigationRoutes.profileSecondary);
  }

  // var percent = NumberFormat("##");
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
                        style: TextStyle(fontSize: 22),
                      )),
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
