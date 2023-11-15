import 'package:flutter/material.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';
import 'package:schuldaten_hub/features/statistics/statistics_view/statistics_view.dart';
import 'package:watch_it/watch_it.dart';

class Statistics extends WatchingStatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  StatisticsController createState() => StatisticsController();
}

class StatisticsController extends State<Statistics> {
  final List<Pupil> pupils = locator<PupilManager>().pupils.value;
  Map<String, int> languageOccurrences = {};
  Map<String, DateTime> enrollments = {};
  @override
  void initState() {
    calculateLanguageOccurrences();

    super.initState();
  }

  calculateLanguageOccurrences() {
    for (Pupil pupil in pupils) {
      languageOccurrences[pupil.language!] =
          (languageOccurrences[pupil.language] ?? 0) + 1;
    }
  }

  List<Pupil> pupilsNotEnrolledOnDate() {
    return pupils.where((pupil) {
      return !(pupil.pupilSince!.month == 8 && pupil.pupilSince!.day == 1);
    }).toList();
  }

  List<Pupil> pupilsInaGivenGroup(String group) {
    List<Pupil> groupPupils = [];
    for (Pupil pupil in pupils) {
      if (pupil.group == group) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<Pupil> pupilsInOGS(List<Pupil> givenPupils) {
    List<Pupil> groupPupils = [];
    for (Pupil pupil in givenPupils) {
      if (pupil.ogs == true) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<Pupil> pupilsWithLanguageSupport(List<Pupil> givenPupils) {
    List<Pupil> groupPupils = [];
    for (Pupil pupil in givenPupils) {
      // if the pupil has a language support as of today, add to list

      if (pupil.migrationSupportEnds != null) {
        if (locator<PupilManager>()
            .hasLanguageSupport(pupil.migrationSupportEnds)) {
          groupPupils.add(pupil);
        }
      }
    }
    return groupPupils;
  }

  List<Pupil> pupilsHadLanguageSupport(List<Pupil> givenPupils) {
    List<Pupil> groupPupils = [];
    for (Pupil pupil in givenPupils) {
      // if the pupil has a language support as of today, add to list
      if (pupil.migrationSupportEnds != null) {
        if (locator<PupilManager>()
            .hadLanguageSupport(pupil.migrationSupportEnds)) {
          groupPupils.add(pupil);
        }
      }
    }
    return groupPupils;
  }

  List<Pupil> schoolyearInaGivenGroup(List<Pupil> group, String schoolyear) {
    List<Pupil> groupPupils = [];
    for (Pupil pupil in group) {
      if (pupil.schoolyear == schoolyear) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  Map<String, int> groupStatistics(List<Pupil> pupils) {
    Map<String, int> groupStatistics = {};
    for (Pupil pupil in pupils) {
      groupStatistics[pupil.group!] = (groupStatistics[pupil.group!] ?? 0) + 1;
    }
    return groupStatistics;
  }

  List<Pupil> pupilsEnrolledAfterDate(DateTime date) {
    return pupils.where((pupil) => pupil.pupilSince!.isAfter(date)).toList();
  }

  List<Pupil> pupilsEnrolledBetweenDates(DateTime startDate, DateTime endDate) {
    return pupils
        .where((pupil) =>
            pupil.pupilSince!.isAfter(startDate) &&
            pupil.pupilSince!.isBefore(endDate))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return StatisticsView(this);
  }
}
