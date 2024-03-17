import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';

const double emojiSize = 22;
List<Widget> admonitionReasonChip(String reason) {
  List<Widget> chips = [];
  if (reason.contains('gm')) {
    chips.add(const Chip(
      labelPadding: EdgeInsets.symmetric(horizontal: 5),
      label: Text(
        '🤜🤕',
        style: TextStyle(fontSize: emojiSize),
      ),
      backgroundColor: filterChipUnselectedColor,
    ));
  }
  if (reason.contains('gl')) {
    chips.add(const Chip(
      labelPadding: EdgeInsets.symmetric(horizontal: 5),
      label: Text(
        '🤜🎓️',
        style: TextStyle(fontSize: emojiSize),
      ),
      backgroundColor: filterChipUnselectedColor,
    ));
  }
  if (reason.contains('gs')) {
    chips.add(const Chip(
      labelPadding: EdgeInsets.symmetric(horizontal: 5),
      label: Text(
        '🤜🏫',
        style: TextStyle(fontSize: emojiSize),
      ),
      backgroundColor: filterChipUnselectedColor,
    ));
  }
  if (reason.contains('ab')) {
    chips.add(
      const Chip(
        labelPadding: EdgeInsets.symmetric(horizontal: 5),
        label: Text(
          '🤬💔',
          style: TextStyle(fontSize: emojiSize),
        ),
        backgroundColor: filterChipUnselectedColor,
      ),
    );
  }
  if (reason.contains('gv')) {
    chips.add(
      const Chip(
        labelPadding: EdgeInsets.symmetric(horizontal: 5),
        label: Text(
          '🚨😱',
          style: TextStyle(fontSize: emojiSize),
        ),
        backgroundColor: filterChipUnselectedColor,
      ),
    );
  }
  if (reason.contains('äa')) {
    chips.add(
      const Chip(
        labelPadding: EdgeInsets.symmetric(horizontal: 5),
        label: Text(
          '😈😖',
          style: TextStyle(fontSize: emojiSize),
        ),
        backgroundColor: filterChipUnselectedColor,
      ),
    );
  }
  if (reason.contains('il')) {
    chips.add(const Chip(
      labelPadding: EdgeInsets.symmetric(horizontal: 5),
      label: Text(
        '🎓️🙉',
        style: TextStyle(fontSize: emojiSize),
      ),
      backgroundColor: filterChipUnselectedColor,
    ));
  }
  if (reason.contains('us')) {
    chips.add(const Chip(
      labelPadding: EdgeInsets.symmetric(horizontal: 5),
      label: Text(
        '🛑🎓️',
        style: TextStyle(fontSize: emojiSize),
      ),
      backgroundColor: filterChipUnselectedColor,
    ));
  }
  if (reason.contains('ss')) {
    chips.add(const Chip(
      labelPadding: EdgeInsets.symmetric(horizontal: 5),
      label: Text(
        '📝',
        style: TextStyle(fontSize: emojiSize),
      ),
      backgroundColor: filterChipUnselectedColor,
    ));
  }
  return chips;
}
