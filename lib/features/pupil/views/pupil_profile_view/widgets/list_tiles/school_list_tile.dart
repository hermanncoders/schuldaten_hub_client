import 'package:flutter/material.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/school_lists/views/school_list_pupils_view/widgets/pupil_school_list_content_list.dart';

schoolListPupilTiles(Pupil pupil) {
  return ListTileTheme(
    contentPadding: const EdgeInsets.all(0),
    dense: true,
    horizontalTitleGap: 0.0,
    minLeadingWidth: 0,
    child: ExpansionTile(
      tilePadding: const EdgeInsets.all(0),
      title: const Row(
        children: [
          // Icon(
          //   Icons.list_alt_rounded,
          //   color: backgroundColor,
          // ),
          // Gap(10),
          Text(
            'Listeneinträge',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
      children: [...pupilSchoolListContentList(pupil)],
    ),
  );
}
