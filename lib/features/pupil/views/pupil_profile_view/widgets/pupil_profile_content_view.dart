import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/features/admonitions/models/admonition.dart';
import 'package:schuldaten_hub/features/admonitions/views/admonition_list_view/widgets/pupil_admonition_content_list.dart';
import 'package:schuldaten_hub/features/attendance/views/widgets/attendance_stats_pupil.dart';
import 'package:schuldaten_hub/features/attendance/views/widgets/pupil_attendance_content_list.dart';
import 'package:schuldaten_hub/features/authorizations/views/pupil_authorizations_content_list.dart';
import 'package:schuldaten_hub/features/learning_view/views/widgets/pupilLearningContentList.dart';
import 'package:schuldaten_hub/features/ogs_view/widgets/pupil_ogs_content_list.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/views/credit_list_view/widgets/pupil_credit_content_list.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/controller/pupil_profile_controller.dart';

import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/list_tiles/pupil_infos_content_list.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/pupil_language_content_list.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/pupil_learning_support_content.dart';
import 'package:schuldaten_hub/features/school_lists/views/school_list_pupils_view/widgets/pupil_school_list_content_list.dart';

Widget pupilProfileContentView(Pupil pupil, List<Admonition> admonitions,
    BuildContext context, PupilProfileController controller) {
  return Expanded(
    child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          if (controller.pupilProfileNavState == 0) ...<Widget>[
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
          ],
          if (controller.pupilProfileNavState == 1) ...<Widget>[
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
          ],
          if (controller.pupilProfileNavState == 2) ...<Widget>[
            const Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Icon(
                Icons.attach_money_rounded,
                color: accentColor,
                size: 24,
              ),
              Gap(5),
              Text('Guthaben',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: backgroundColor,
                  ))
            ]),
            const Gap(15),
            ...pupilCreditContentList(pupil, context),
          ],
          if (controller.pupilProfileNavState == 3) ...<Widget>[
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Icon(
                Icons.calendar_month_rounded,
                color: Colors.grey[700],
                size: 24,
              ),
              const Gap(5),
              const Text('Fehlzeiten',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: backgroundColor,
                  ))
            ]),
            const Gap(15),
            attendanceStats(pupil),
            const Gap(10),
            ...pupilAttendanceContentList(pupil, context),
          ],
          if (controller.pupilProfileNavState == 4) ...<Widget>[
            const Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Color.fromARGB(255, 239, 66, 66),
                size: 24,
              ),
              Gap(5),
              Text('Vorfälle',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: backgroundColor,
                  ))
            ]),
            const Gap(15),
            ...pupilAdmonitionsContentList(pupil, context, admonitions),
          ],
          if (controller.pupilProfileNavState == 5) ...<Widget>[
            const Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
          ],
          if (controller.pupilProfileNavState == 6) ...<Widget>[
            const Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
          ],
          if (controller.pupilProfileNavState == 7) ...<Widget>[
            const Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
          ],
          if (controller.pupilProfileNavState == 8) ...<Widget>[
            const Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Icon(
                Icons.support_rounded,
                color: Colors.red,
                size: 24,
              ),
              Gap(5),
              Text('Förderung',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: backgroundColor,
                  ))
            ]),
            const Gap(15),
            ...pupilLearningSupportContentList(pupil, context),
          ],
          if (controller.pupilProfileNavState == 9) ...<Widget>[
            const Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
          ],
        ],
      ),
    ),
  );
}
