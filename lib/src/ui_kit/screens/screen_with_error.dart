import 'package:flutter/material.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';

class ScreenWithError extends StatelessWidget {
  const ScreenWithError({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.of(context).page404Header),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Center(
                child:
                    Text(Localization.of(context).navigationErrorScteenText)),
          ],
        ),
      ),
    );
  }
}
