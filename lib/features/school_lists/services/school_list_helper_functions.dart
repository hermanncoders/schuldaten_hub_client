import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/school_lists/models/school_list.dart';

String listOwners(SchoolList schoolList) {
  String owners = '';
  if (schoolList.visibility == 'public') {
    return 'Hermannschule';
  }
  if (schoolList.visibility == 'private') {
    return '';
  }
  schoolList.visibility.split('*').forEach((element) {
    if (element.isNotEmpty) {
      owners += ' - $element';
    }
  });
  return owners;
}

String shareList(String teacher, SchoolList schoolList) {
  String visibility = schoolList.visibility;
  visibility += '*$teacher';
  return visibility;
}

int totalShownPupilsMarkedWithYesNoOrNull(
    SchoolList schoolList, List<Pupil> pupilsInList, bool? yesNoOrNull) {
  int count = 0;
  for (Pupil pupil in pupilsInList) {
    if (pupil.pupilLists != null) {
      if (pupil.pupilLists!.any((element) =>
          element.originList == schoolList.listId &&
          element.pupilListStatus == yesNoOrNull)) {
        count++;
      }
    }
  }
  return count;
}

int totalShownPupilsWithComment(
    SchoolList schoolList, List<Pupil> pupilsInList) {
  int count = 0;
  for (Pupil pupil in pupilsInList) {
    if (pupil.pupilLists != null) {
      if (pupil.pupilLists!.any((element) =>
          element.originList == schoolList.listId &&
          element.pupilListComment != null &&
          element.pupilListComment!.isNotEmpty)) {
        count++;
      }
    }
  }
  return count;
}
