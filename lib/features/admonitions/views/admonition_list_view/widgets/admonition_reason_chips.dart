import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';

List<Widget> admonitionReasonChip(String reason) {
  List<Widget> chips = [];
  if (reason.contains('gm')) {
    chips.add(const Chip(
      label: Text('🤜🤕'),
      backgroundColor: filterChipUnselectedColor,
    ));
  }
  if (reason.contains('gs')) {
    chips.add(const Chip(
      label: Text('🤜🏫'),
      backgroundColor: filterChipUnselectedColor,
    ));
  }
  if (reason.contains('äa')) {
    chips.add(
      const Chip(
        label: Text('🤬🤕'),
        backgroundColor: filterChipUnselectedColor,
      ),
    );
  }
  if (reason.contains('il')) {
    chips.add(const Chip(
      label: Text('🎓️🙉'),
      backgroundColor: filterChipUnselectedColor,
    ));
  }
  if (reason.contains('us')) {
    chips.add(const Chip(
      label: Text('🛑🎓️'),
      backgroundColor: filterChipUnselectedColor,
    ));
  }
  if (reason.contains('ss')) {
    chips.add(const Chip(
      label: Text('📝'),
      backgroundColor: filterChipUnselectedColor,
    ));
  }
  return chips;
}
