import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';

import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/dialogs/pickup_time_dialog.dart';

ogsListTiles(Pupil pupil, context) {
  return ListTileTheme(
    contentPadding: const EdgeInsets.all(0),
    dense: true,
    horizontalTitleGap: 0.0,
    minLeadingWidth: 0,
    child: ExpansionTile(
      iconColor: backgroundColor,
      tilePadding: const EdgeInsets.all(0),
      title: const Text(
        'OGS',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      children: [
        Row(
          children: [
            const Text('Abholzeit:', style: TextStyle(fontSize: 18.0)),
            const Gap(10),
            InkWell(
              onTap: () => pickUpTimeDialog(context, pupil, pupil.pickUpTime),
              child: Text(
                  locator<PupilManager>().pickupTimePredicate(pupil.pickUpTime),
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold)),
            )
          ],
        ),
        const Gap(10),
        Row(
          children: [
            const Text('OGS Infos:', style: TextStyle(fontSize: 18.0)),
            const Gap(10),
            Text(pupil.ogsInfo ?? 'Kein Eintrag',
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold))
          ],
        ),
      ],
    ),
  );
}
