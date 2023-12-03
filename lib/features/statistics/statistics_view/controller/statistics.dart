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

  List<Pupil> pupilsNotSpeakingGerman(List<Pupil> givenPupils) {
    return givenPupils.where((pupil) => pupil.language != 'Deutsch').toList();
  }

  List<Pupil> pupilsNotEnrolledOnDate(List<Pupil> givenPupils) {
    return givenPupils.where((pupil) {
      return !(pupil.pupilSince!.month == 8 && pupil.pupilSince!.day == 1);
    }).toList();
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

  List<Pupil> preschoolRevisionSupportInaGivenGroup(List<Pupil> group) {
    List<Pupil> groupPupils = [];
    for (Pupil pupil in group) {
      if (pupil.preschoolRevision == 2) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<Pupil> preschoolRevisionSpecialNeedsInaGivenGroup(List<Pupil> group) {
    List<Pupil> groupPupils = [];
    for (Pupil pupil in group) {
      if (pupil.preschoolRevision == 3) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<Pupil> specialNeedsInAGivenGroup(List<Pupil> group) {
    List<Pupil> groupPupils = [];
    for (Pupil pupil in group) {
      if (pupil.specialNeeds != null) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<Pupil> developmentPlan1InAGivenGroup(List<Pupil> group) {
    List<Pupil> groupPupils = [];
    for (Pupil pupil in group) {
      if (pupil.individualDevelopmentPlan == 1) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<Pupil> developmentPlan2InAGivenGroup(List<Pupil> group) {
    List<Pupil> groupPupils = [];
    for (Pupil pupil in group) {
      if (pupil.individualDevelopmentPlan == 2) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<Pupil> developmentPlan3InAGivenGroup(List<Pupil> group) {
    List<Pupil> groupPupils = [];
    for (Pupil pupil in group) {
      if (pupil.individualDevelopmentPlan == 3) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<Pupil> preschoolRevisionNotAvailable(List<Pupil> group) {
    List<Pupil> groupPupils = [];
    for (Pupil pupil in group) {
      if (pupil.preschoolRevision == 0) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<Pupil> preschoolRevisionOk(List<Pupil> group) {
    List<Pupil> groupPupils = [];
    for (Pupil pupil in group) {
      if (pupil.preschoolRevision == 1) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<Pupil> preschoolRevisionSupport(List<Pupil> group) {
    List<Pupil> groupPupils = [];
    for (Pupil pupil in group) {
      if (pupil.preschoolRevision == 2) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<Pupil> preschoolRevisionSpecialNeeds(List<Pupil> group) {
    List<Pupil> groupPupils = [];
    for (Pupil pupil in group) {
      if (pupil.preschoolRevision == 3) {
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

  @override
  Widget build(BuildContext context) {
    return StatisticsView(this);
  }
}
