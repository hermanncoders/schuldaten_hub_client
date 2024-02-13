import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/features/ogs_view/widgets/pupil_ogs_content_list.dart';

import 'package:schuldaten_hub/features/pupil/models/pupil.dart';

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
      children: [...pupilOgsContentList(pupil, context)],
    ),
  );
}
