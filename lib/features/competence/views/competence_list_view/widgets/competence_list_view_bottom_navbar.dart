import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/features/competence/models/competence.dart';
import 'package:schuldaten_hub/features/competence/services/competence_filter_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/competence/views/competence_list_view/widgets/competence_filter_bottom_sheet.dart';

BottomAppBar competenceListViewBottomNavBar(
    BuildContext context, List<Competence> competences) {
  return BottomAppBar(
    // padding: EdgeInsets.all(9),
    shape: null,
    color: backgroundColor,
    child: IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Row(
          children: [
            IconButton(
              tooltip: 'Open navigation menu',
              icon: const Icon(
                Icons.arrow_back,
                size: 35,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const Spacer(),
            IconButton(
              tooltip: 'aktualisieren',
              icon: const Icon(Icons.update_rounded),
              onPressed: () {
                locator<CompetenceFilterManager>()
                    .refreshFilteredCompetences(competences);
              },
            ),
            IconButton(
              tooltip: 'Filter',
              icon: const Icon(Icons.filter_list_rounded),
              onPressed: () => showCompetenceFilterBottomSheet(context),
            ),
            const Gap(10)
          ],
        ),
      ),
    ),
  );
}
