import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';

languageListTiles(Pupil pupil) {
  return ListTileTheme(
    contentPadding: const EdgeInsets.all(0),
    dense: true,
    horizontalTitleGap: 0.0,
    minLeadingWidth: 0,
    child: ExpansionTile(
      tilePadding: const EdgeInsets.all(0),
      title: const Text(
        'Sprache',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      children: [
        Row(
          children: [
            const Text('Familiensprache:', style: TextStyle(fontSize: 18.0)),
            const Gap(10),
            Text(pupil.language!,
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold))
          ],
        ),
        const Gap(10),
        Row(
          children: [
            const Text('Erstförderung:', style: TextStyle(fontSize: 18.0)),
            const Gap(10),
            Text(
                pupil.migrationSupportEnds != null
                    ? 'bis : ${pupil.migrationSupportEnds!.formatForUser()}'
                    : 'keine',
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold)),
          ],
        ),
        const Gap(10),
        Row(
          children: [
            const Text(
              'Deutsch Kind:',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18.0),
            ),
            const Gap(10),
            pupil.communicationPupil == null
                ? const Text(
                    'kein Eintrag',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  )
                : Text(
                    '${pupil.communicationPupil}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  )
          ],
        ),
        const Gap(10),
        Row(
          children: [
            const Text(
              'Deutsch Tutor/in 1:',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18.0),
            ),
            const Gap(10),
            pupil.communicationTutor1 == null
                ? const Text(
                    'kein Eintrag',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  )
                : Text(
                    '${pupil.communicationTutor1}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  )
          ],
        ),
        const Gap(10),
        Row(
          children: [
            const Text(
              'Deutsch Tutor/in 2:',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18.0),
            ),
            const Gap(10),
            pupil.communicationTutor2 == null
                ? const Text(
                    'kein Eintrag',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  )
                : Text(
                    '${pupil.communicationTutor2}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  )
          ],
        ),
        const Gap(10),
      ],
    ),
  );
}
