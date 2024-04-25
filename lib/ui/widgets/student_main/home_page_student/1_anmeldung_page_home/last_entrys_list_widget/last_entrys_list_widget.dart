import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../../../fake_data/anmeldungen_fake_data/anmeldungen_fake.dart';
import '../../../../components/elements_components/entrys_card_component.dart';

class LastEntrysListWidget extends StatefulWidget {
  const LastEntrysListWidget({super.key});

  @override
  State<LastEntrysListWidget> createState() => _LastEntrysListWidgetState();
}

class _LastEntrysListWidgetState extends State<LastEntrysListWidget> {
  final _anmeldungen = fakePittyAnmeldungen;

  @override
  Widget build(BuildContext context) {
    final List<EntrysCardComponent> _cards = _anmeldungen
        .map((anmeldung) => EntrysCardComponent(anmeldungData: anmeldung))
        .toList();

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Letzte Anmeldungen',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          // ListView.builder(
          //     // padding: EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 40),
          //     itemCount: fakeAnmeldungen.length,
          //     // itemExtent: 80,
          //     itemBuilder: (BuildContext context, int index) {
          //       final anmeldung = fakeAnmeldungen[index];
          //       return EntrysCardComponent(
          //         anmeldungData: anmeldung,
          //       );
          //     })
          Column(
            children: _cards,
          )

          // EntrysCardComponent(
          //   anmeldungData: _anmeldungen[0],
          // )
        ],
      ),
    );
  }
}
