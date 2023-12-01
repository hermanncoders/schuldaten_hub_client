import 'package:schuldaten_hub/features/pupil/models/pupil.dart';

int missedclassSum(Pupil pupil) {
  // count the number of missed classes - avoid null when missedClasses is empty
  int missedclassCount = 0;
  if (pupil.pupilMissedClasses != null) {
    missedclassCount = pupil.pupilMissedClasses!
        .where((element) =>
            element.missedType == 'missed' && element.excused == false)
        .length;
  }
  return missedclassCount;
}

int missedclassUnexcusedSum(Pupil pupil) {
  // count the number of unexcused missed classes
  int missedclassCount = 0;
  if (pupil.pupilMissedClasses != null) {
    missedclassCount = pupil.pupilMissedClasses!
        .where((element) =>
            element.missedType == 'missed' && element.excused == true)
        .length;
  }
  return missedclassCount;
}

lateUnexcusedSum(Pupil pupil) {
  int missedClassUnexcusedCount = 0;
  if (pupil.pupilMissedClasses != null) {
    missedClassUnexcusedCount = pupil.pupilMissedClasses!
        .where((element) =>
            element.missedType == 'late' && element.excused == true)
        .length;
  }
  return missedClassUnexcusedCount;
}

int contactedSum(Pupil pupil) {
  int contactedCount = pupil.pupilMissedClasses!
      .where((element) => element.contacted != '0')
      .length;

  return contactedCount;
}
