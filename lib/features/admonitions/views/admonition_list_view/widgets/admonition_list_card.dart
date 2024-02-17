import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/common/widgets/avatar.dart';
import 'package:schuldaten_hub/common/widgets/custom_expansion_tile.dart';
import 'package:schuldaten_hub/features/admonitions/models/admonition.dart';
import 'package:schuldaten_hub/features/admonitions/views/admonition_list_view/controller/admonition_list_controller.dart';
import 'package:schuldaten_hub/features/admonitions/views/admonition_list_view/widgets/pupil_admonition_content_list.dart';
import 'package:schuldaten_hub/features/first_level_views/bottom_nav_bar.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/controller/pupil_profile_controller.dart';
import 'package:schuldaten_hub/common/widgets/list_tile.dart';
import 'package:watch_it/watch_it.dart';

class AdmonitionListCard extends WatchingStatefulWidget {
  final AdmonitionListController controller;
  final Pupil passedPupil;
  const AdmonitionListCard(this.controller, this.passedPupil, {super.key});

  @override
  State<AdmonitionListCard> createState() => _AdmonitionListCardState();
}

class _AdmonitionListCardState extends State<AdmonitionListCard> {
  late CustomExpansionTileController _tileController;

  @override
  void initState() {
    super.initState();
    _tileController = CustomExpansionTileController();
  }

  @override
  Widget build(BuildContext context) {
    List<Pupil> pupils = watchValue((PupilFilterManager x) => x.filteredPupils);
    final Pupil pupil = pupils
        .where((element) => element.internalId == widget.passedPupil.internalId)
        .first;
    final List<Admonition> admonitions = List.from(pupil.pupilAdmonitions!);
    admonitions.sort((a, b) => b.admonishedDay.compareTo(a.admonishedDay));

    return Card(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            avatarWithBadges(pupil, 80),
            Expanded(
              child: Column(
                children: [
                  const Gap(10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: InkWell(
                            onTap: () {
                              locator<BottomNavManager>()
                                  .setPupilProfileNavPage(4);
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => PupilProfile(
                                  pupil,
                                ),
                              ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                pupil.firstName!,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const Gap(3),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => PupilProfile(
                                  pupil,
                                ),
                              ));
                            },
                            child: Text(
                              pupil.lastName!,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const Gap(7),
                  Row(
                    children: [
                      const Text('zuletzt:'),
                      const Gap(10),
                      Text(
                        pupil.pupilAdmonitions!.isEmpty
                            ? ''
                            : pupil.pupilAdmonitions!.last.admonishedDay
                                .formatForUser(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 80,
              child: InkWell(
                onTap: () {
                  if (_tileController.isExpanded) {
                    _tileController.collapse();
                  } else {
                    _tileController.expand();
                  }
                },
                child: Column(
                  children: [
                    const Gap(20),
                    const Text(
                      'Ereignisse',
                    ),
                    const Gap(5),
                    Center(
                      child: Text(
                        pupil.pupilAdmonitions?.length.toString() ??
                            0.toString(),
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: backgroundColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
            child: listTiles(
              const Text('Vorfälle',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              context,
              _tileController,
              pupilAdmonitionsContentList(pupil, context, admonitions),
            )),
      ],
    ));
  }
}
