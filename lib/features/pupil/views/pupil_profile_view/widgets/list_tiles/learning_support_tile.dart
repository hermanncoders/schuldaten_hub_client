import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_helper_functions.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/dialogs/individual_development_plan_dialog.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/dialogs/preschool_revision_dialog.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/list_tiles/pupil_category_widgets/category_goal_card.dart';

import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/list_tiles/pupil_category_widgets/pupil_category_tree.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/pupil_learning_support_content.dart';

learningSupportTiles(Pupil pupil, context) {
  return ListTileTheme(
    contentPadding: const EdgeInsets.all(0),
    dense: true,
    horizontalTitleGap: 0.0,
    minLeadingWidth: 0,
    child: ExpansionTile(
      iconColor: backgroundColor,
      tilePadding: const EdgeInsets.all(0),
      title: const Row(
        children: [
          // Icon(
          //   Icons.support_rounded,
          //   color: backgroundColor,
          // ),
          // Gap(10),
          Text(
            'Förderung',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
      children: [
        ...pupilLearningSupportContentList(pupil, context),
      ],
    ),
  );
}
