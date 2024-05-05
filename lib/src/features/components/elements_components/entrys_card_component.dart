import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../old_files/fake_data/anmeldungen_fake_data/anmeldungen_fake.dart';
import '../../../core/styles/color_scheme_my.dart';

class EntrysCardComponent extends StatefulWidget {
  final AnmeldungEntry anmeldungData;
  const EntrysCardComponent({super.key, required this.anmeldungData});

  @override
  State<EntrysCardComponent> createState() => _EntrysCardComponentState();
}

class _EntrysCardComponentState extends State<EntrysCardComponent> {
  var dateFormat = DateFormat('dd.MM.yy');

  get anmeldungData {
    return widget.anmeldungData;
  }

  void deleteEntry() {
    print('${anmeldungData.type} Entry Deleted');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      // width: 600,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 8),
      constraints: const BoxConstraints(maxWidth: 600),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12)),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
                width: 44,
                height: 44,
                constraints: const BoxConstraints(maxWidth: 600),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 150, 146, 249),
                    border:
                        Border.all(width: 1, color: MyAppColorScheme.primary),
                    borderRadius: BorderRadius.circular(8)),
                child: Stack(alignment: AlignmentDirectional.center, children: [
                  if (anmeldungData.type == 'Schule')
                    const Icon(
                      FontAwesomeIcons.schoolFlag,
                      color: Colors.white,
                      size: 20,
                    ),
                  if (anmeldungData.type == 'Heim')
                    const Icon(
                      Icons.home_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                ])),
            Text(
              /////maxCharacters
              anmeldungData.type.length > 10
                  ? anmeldungData.type.substring(0, 10) + '...'
                  : anmeldungData.type,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(dateFormat.format(anmeldungData.date)),
            IconButton(
                onPressed: deleteEntry,
                icon: const Icon(Icons.delete_outline_outlined,
                    color: Colors.red)),
          ]),
    );
  }
}
