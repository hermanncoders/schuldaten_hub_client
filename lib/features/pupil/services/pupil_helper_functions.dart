import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';

Pupil findPupilById(int pupilId) {
  final pupils = locator<PupilManager>().pupils.value;
  final Pupil pupil =
      pupils.singleWhere((element) => element.internalId == pupilId);
  return pupil;
}

List<Pupil> pupilsFromPupilIds(List<int> pupilIds) {
  List<Pupil> pupilsfromPupilIds = [];
  final pupils = locator<PupilManager>().pupils.value;
  pupilsfromPupilIds =
      pupils.where((element) => pupilIds.contains(element.internalId)).toList();
  return pupilsfromPupilIds;
}

List<int> pupilIdsFromPupils(List<Pupil> pupils) {
  List<int> pupilIds = [];
  for (Pupil pupil in pupils) {
    pupilIds.add(pupil.internalId);
  }
  return pupilIds;
}

String preschoolRevisionPredicate(int value) {
  switch (value) {
    case 0:
      return 'nicht vorhanden';
    case 1:
      return "unauffällig";
    case 2:
      return "Förderbedarf";
    case 3:
      return "AO-SF prüfen";
    default:
      return "Falscher Wert im Server";
  }
}

String pickupTimePredicate(String? value) {
  switch (value) {
    case null:
      return 'k.A.';
    case '0':
      return '14:00';
    case '1':
      return "14:00";
    case '2':
      return "15:00";
    case '3':
      return "16:00";
    default:
      return "Falscher Wert im Server";
  }
}

String communicationPredicate(String? value) {
  switch (value) {
    case null:
      return 'keine Angabe';
    case '0':
      return 'nicht';
    case '1':
      return "einfache Anliegen";
    case '2':
      return "komplexere Informationen";
    case '3':
      return "ohne Probleme";
    case '4':
      return "unbekannt";
    default:
      return "Falscher Wert im Server";
  }
}

List<Pupil> siblings(Pupil pupil) {
  if (pupil.family == null) {
    return [];
  }
  List<Pupil> pupilSiblings = [];
  final pupils = locator<PupilManager>().pupils.value;
  pupilSiblings =
      pupils.where((element) => element.family == pupil.family).toList();
  pupilSiblings.remove(pupil);
  return pupilSiblings;
}

bool hasLanguageSupport(DateTime? date) {
  if (date != null) {
    return date.isAfter(DateTime.now());
  }
  return false;
}

bool hadLanguageSupport(DateTime? date) {
  if (date != null) {
    return date.isBefore(DateTime.now());
  }
  return false;
}
