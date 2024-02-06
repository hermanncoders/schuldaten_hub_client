import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_helper_functions.dart';

Widget communicationValues(String values) {
  String understandingValue = values.substring(0, 1);
  String speakingValue = values.substring(1, 2);
  String readingValue = values.substring(2, 3);
  return Column(
    children: [
      Row(
        children: [
          const Icon(Icons.hearing),
          const Gap(5),
          Text(communicationPredicate(understandingValue)),
          const Gap(5),
          const Icon(Icons.chat_bubble_outline_rounded),
          const Gap(5),
          Text(communicationPredicate(speakingValue)),
          const Gap(5),
          const Icon(Icons.book),
          const Gap(5),
          Text(communicationPredicate(readingValue)),
        ],
      )
    ],
  );
}
