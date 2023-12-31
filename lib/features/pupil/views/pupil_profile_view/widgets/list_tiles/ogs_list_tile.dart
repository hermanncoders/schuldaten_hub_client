import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/confirmation_dialog.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/information_dialog.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/long_textfield_dialog.dart';

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
            ),
            const Gap(5),
            const Text('Uhr:', style: TextStyle(fontSize: 18.0)),
          ],
        ),
        const Gap(10),
        const Row(
          children: [
            Text('OGS Infos:', style: TextStyle(fontSize: 18.0)),
            Gap(5),
          ],
        ),
        const Gap(5),
        InkWell(
          onTap: () async {
            final String? ogsInfo = await longTextFieldDialog(
                'OGS Informationen', pupil.ogsInfo, context);
            if (ogsInfo == null) return;
            await locator<PupilManager>()
                .patchPupil(pupil.internalId, 'ogs_info', ogsInfo);
            informationDialog(context, 'Besondere Informationen geändert',
                'Die neuen Infos wurden im Server geschrieben!');
          },
          onLongPress: () async {
            if (pupil.ogsInfo == null) return;
            final bool? confirm = await confirmationDialog(
                context,
                'OGS Infos löschen',
                'OGS Informationen für dieses Kind löschen?');
            if (confirm == false || confirm == null) return;
            await locator<PupilManager>()
                .patchPupil(pupil.internalId, 'ogs_info', null);
          },
          child: Row(
            children: [
              Flexible(
                child: pupil.ogsInfo != null
                    ? Text(pupil.ogsInfo!,
                        softWrap: true,
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold))
                    : const Text(
                        'keine Informationen',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
              ),
            ],
          ),
        ),
        const Gap(10),
      ],
    ),
  );
}
