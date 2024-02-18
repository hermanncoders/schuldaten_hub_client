import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/paddings.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/admonitions/models/admonition.dart';
import 'package:schuldaten_hub/features/admonitions/views/admonition_list_view/controller/admonition_list_controller.dart';
import 'package:schuldaten_hub/features/admonitions/views/admonition_list_view/widgets/pupil_admonition_content_list.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_ranking_list_view/controller/attendance_ranking_list_controller.dart';
import 'package:schuldaten_hub/features/attendance/views/widgets/attendance_stats_pupil.dart';
import 'package:schuldaten_hub/features/attendance/views/widgets/pupil_attendance_content_list.dart';
import 'package:schuldaten_hub/features/authorizations/views/pupil_authorizations_content_list.dart';
import 'package:schuldaten_hub/features/landing_views/bottom_nav_bar.dart';
import 'package:schuldaten_hub/features/learning_support/views/learning_support_list_view/controller/learning_support_list_controller.dart';
import 'package:schuldaten_hub/features/learning/views/widgets/pupil_learning_content_list.dart';
import 'package:schuldaten_hub/features/ogs/widgets/pupil_ogs_content_list.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/credit/controller/credit_list_controller.dart';
import 'package:schuldaten_hub/features/credit/widgets/pupil_credit_content_list.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/controller/pupil_profile_controller.dart';

import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/pupil_infos_content_list.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/pupil_profile_language_content_list.dart';
import 'package:schuldaten_hub/features/learning_support/views/pupil_profile_learning_support_content.dart';
import 'package:schuldaten_hub/features/school_lists/views/school_list_pupils_view/widgets/pupil_school_list_content_list.dart';

Widget pupilProfileContentView(Pupil pupil, List<Admonition> admonitions,
    BuildContext context, PupilProfileController controller) {
  return Expanded(
    child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          if (locator<BottomNavManager>().pupilProfileNavState.value ==
              0) ...<Widget>[
            Card(
              color: pupilProfileCardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: pupilProfileCardPadding,
                child: Column(children: [
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info_rounded,
                        color: backgroundColor,
                        size: 24,
                      ),
                      Gap(5),
                      Text(
                        'Infos',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: backgroundColor),
                      ),
                    ],
                  ),
                  const Gap(15),
                  ...pupilInfosContentList(pupil, context)
                ]),
              ),
            )
          ],
          if (locator<BottomNavManager>().pupilProfileNavState.value ==
              1) ...<Widget>[
            Card(
              color: pupilProfileCardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: pupilProfileCardPadding,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.language_rounded,
                            color: groupColor,
                            size: 24,
                          ),
                          Gap(5),
                          Text(
                            'Sprache(n)',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: backgroundColor),
                          ),
                        ],
                      ),
                      const Gap(15),
                      ...pupilLanguageContentList(pupil, context)
                    ]),
              ),
            ),
          ],
          if (locator<BottomNavManager>().pupilProfileNavState.value ==
              2) ...<Widget>[
            Card(
              color: pupilProfileCardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: pupilProfileCardPadding,
                child: Column(children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Icon(
                      Icons.attach_money_rounded,
                      color: accentColor,
                      size: 24,
                    ),
                    const Gap(5),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const CreditList(),
                        ));
                      },
                      child: const Text('Guthaben',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: backgroundColor,
                          )),
                    ),
                    const Spacer(),
                    Text(
                      pupil.credit.toString(),
                      style: const TextStyle(
                          color: groupColor,
                          fontSize: 60,
                          fontWeight: FontWeight.bold),
                    ),
                    const Gap(20),
                  ]),
                  //const Gap(15),
                  ...pupilCreditContentList(pupil, context),
                ]),
              ),
            ),
          ],
          if (locator<BottomNavManager>().pupilProfileNavState.value ==
              3) ...<Widget>[
            Card(
              color: pupilProfileCardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: pupilProfileCardPadding,
                child: Column(children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Icon(
                      Icons.calendar_month_rounded,
                      color: Colors.grey[700],
                      size: 24,
                    ),
                    const Gap(5),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const AttendanceRankingList(),
                        ));
                      },
                      child: const Text('Fehlzeiten',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: backgroundColor,
                          )),
                    )
                  ]),
                  const Gap(15),
                  attendanceStats(pupil),
                  const Gap(10),
                  ...pupilAttendanceContentList(pupil, context),
                ]),
              ),
            ),
          ],
          if (locator<BottomNavManager>().pupilProfileNavState.value ==
              4) ...<Widget>[
            Card(
              color: pupilProfileCardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: pupilProfileCardPadding,
                child: Column(children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    const Icon(
                      Icons.warning_amber_rounded,
                      color: Color.fromARGB(255, 239, 66, 66),
                      size: 24,
                    ),
                    const Gap(5),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const AdmonitionList(),
                        ));
                      },
                      child: const Text('Ereignisse',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: backgroundColor,
                          )),
                    )
                  ]),
                  const Gap(15),
                  ...pupilAdmonitionsContentList(pupil, context, admonitions),
                ]),
              ),
            ),
          ],
          if (locator<BottomNavManager>().pupilProfileNavState.value ==
              5) ...<Widget>[
            Card(
              color: pupilProfileCardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: pupilProfileCardPadding,
                child: Column(children: [
                  const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.restaurant,
                          color: groupColor,
                          size: 24,
                        ),
                        Gap(5),
                        Text('OGS Infos',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: backgroundColor,
                            ))
                      ]),
                  const Gap(15),
                  ...pupilOgsContentList(pupil, context),
                ]),
              ),
            ),
          ],
          if (locator<BottomNavManager>().pupilProfileNavState.value ==
              6) ...<Widget>[
            Card(
              color: pupilProfileCardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: pupilProfileCardPadding,
                child: Column(children: [
                  const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.rule,
                          color: accentColor,
                          size: 24,
                        ),
                        Gap(5),
                        Text('Listen',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: backgroundColor,
                            ))
                      ]),
                  const Gap(15),
                  ...pupilSchoolListContentList(pupil),
                ]),
              ),
            ),
          ],
          if (locator<BottomNavManager>().pupilProfileNavState.value ==
              7) ...<Widget>[
            Card(
              color: pupilProfileCardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: pupilProfileCardPadding,
                child: Column(children: [
                  const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.fact_check_rounded,
                          color: backgroundColor,
                          size: 24,
                        ),
                        Gap(5),
                        Text('Einwilligungen',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: backgroundColor,
                            ))
                      ]),
                  const Gap(15),
                  ...pupilAuthorizationsContentList(pupil),
                ]),
              ),
            ),
          ],
          if (locator<BottomNavManager>().pupilProfileNavState.value ==
              8) ...<Widget>[
            Card(
              color: pupilProfileCardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: pupilProfileCardPadding,
                child: Column(children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    const Icon(
                      Icons.support_rounded,
                      color: Colors.red,
                      size: 24,
                    ),
                    const Gap(5),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const LearningSupportList(),
                        ));
                      },
                      child: const Text('Förderung',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: backgroundColor,
                          )),
                    )
                  ]),
                  const Gap(15),
                  ...pupilLearningSupportContentList(pupil, context),
                ]),
              ),
            ),
          ],
          if (locator<BottomNavManager>().pupilProfileNavState.value ==
              9) ...<Widget>[
            Card(
              color: pupilProfileCardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: pupilProfileCardPadding,
                child: Column(children: [
                  const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lightbulb,
                          color: accentColor,
                          size: 24,
                        ),
                        Gap(5),
                        Text('Lernen',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: backgroundColor,
                            ))
                      ]),
                  const Gap(15),
                  ...pupilLearningContentList(pupil, context),
                ]),
              ),
            ),
          ],
          const Gap(20),
        ],
      ),
    ),
  );
}
