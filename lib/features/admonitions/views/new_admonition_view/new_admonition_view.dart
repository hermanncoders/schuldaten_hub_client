import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/schoolday_manager.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/common/widgets/date_picker.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/information_dialog.dart';
import 'package:schuldaten_hub/features/admonitions/services/admonition_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';

class NewAdmonitionView extends StatefulWidget {
  final int pupilId;

  const NewAdmonitionView({
    super.key,
    required this.pupilId,
  });

  @override
  NewAdmonitionViewState createState() => NewAdmonitionViewState();
}

class NewAdmonitionViewState extends State<NewAdmonitionView> {
  String admonitionTypeDropdown = 'choose';
  bool violenceAgainstPeople = false;
  bool violenceAgainstThings = false;
  bool annoyOthers = false;
  bool ignoreTeacherInstructions = false;
  bool disturbLesson = false;
  bool parentTalk = false;
  bool other = false;

  DateTime thisDate = locator<SchooldayManager>().thisDate.value;
  String _getDropdownItemText(String value) {
    switch (value) {
      case 'choose':
        return 'bitte wählen';
      case 'rk':
        return 'rote Karte';
      case 'rkogs':
        return 'rote Karte - OGS';
      case 'rkabh':
        return 'rote Karte + abholen';
      case 'Eg':
        return 'Elterngespräch';
      case 'other':
        return 'sonstiges';
      default:
        return '';
    }
  }

  void postAdmonition(BuildContext context) async {
    String admonitionReason = '';
    if (violenceAgainstPeople == true) {
      admonitionReason = '${admonitionReason}gm*';
    }
    if (violenceAgainstThings == true) {
      admonitionReason = '${admonitionReason}gs*';
    }
    if (annoyOthers == true) {
      admonitionReason = '${admonitionReason}äa*';
    }
    if (ignoreTeacherInstructions == true) {
      admonitionReason = '${admonitionReason}il*';
    }
    if (disturbLesson == true) {
      admonitionReason = '${admonitionReason}us*';
    }
    if (parentTalk == true) {
      admonitionReason = '${admonitionReason}Eg*';
    }
    if (other == true) {
      admonitionReason = '${admonitionReason}ss*';
    }
    await locator<AdmonitionManager>().postAdmonition(
        widget.pupilId, thisDate, admonitionTypeDropdown, admonitionReason);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text('Neues Ereignis'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Gap(10),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Ereignis',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Gap(10),
              DropdownButton<String>(
                isDense: true,
                underline: Container(),
                style: subtitle,
                value: admonitionTypeDropdown,
                onChanged: (String? newValue) {
                  setState(() {
                    admonitionTypeDropdown = newValue!;
                  });
                },
                items: <String>['choose', 'rk', 'rkogs', 'rkabh', 'Eg', 'other']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      _getDropdownItemText(value),
                      style: TextStyle(
                          color:
                              value == 'choose' ? Colors.red : backgroundColor,
                          fontSize: 20),
                    ),
                  );
                }).toList(),
              ),
              const Gap(10),
              Row(
                children: [
                  const Text('am', style: subtitle),
                  const Gap(5),
                  IconButton(
                    onPressed: () async {
                      final DateTime newDate =
                          await selectDate(context, thisDate);
                      setState(() {
                        thisDate = newDate;
                      });
                    },
                    icon: const Icon(Icons.calendar_today_rounded,
                        color: backgroundColor),
                  ),
                  InkWell(
                    onTap: () async {
                      final DateTime newDate =
                          await selectDate(context, thisDate);
                      setState(() {
                        thisDate = newDate;
                      });
                    },
                    child: Text(
                      thisDate.formatForUser(),
                      style: title,
                    ),
                  ),
                ],
              ),
              const Gap(5),
              const Text(
                'Grund',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const Gap(5),
              Row(
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: 2,
                      runSpacing: 0,
                      children: [
                        FilterChip(
                          selectedColor: admonitionReasonChipSelectedColor,
                          checkmarkColor:
                              admonitionReasonChipSelectedCheckColor,
                          backgroundColor: admonitionReasonChipUnselectedColor,
                          label: const Text(
                            ' 🤜🤕 Gewalt gegen Menschen',
                            style: filterItemsTextStyle,
                          ),
                          selected: violenceAgainstPeople,
                          onSelected: (value) {
                            setState(() {
                              violenceAgainstPeople = value;
                            });
                          },
                        ),
                        FilterChip(
                          selectedColor: admonitionReasonChipSelectedColor,
                          checkmarkColor:
                              admonitionReasonChipSelectedCheckColor,
                          backgroundColor: admonitionReasonChipUnselectedColor,
                          label: const Text(
                            '🤜🏫 Gewalt gegen Sachen',
                            style: filterItemsTextStyle,
                          ),
                          selected: violenceAgainstThings,
                          onSelected: (value) {
                            setState(() {
                              violenceAgainstThings = value;
                            });
                          },
                        ),
                        FilterChip(
                          selectedColor: admonitionReasonChipSelectedColor,
                          checkmarkColor:
                              admonitionReasonChipSelectedCheckColor,
                          backgroundColor: admonitionReasonChipUnselectedColor,
                          label: const Text(
                            '🤬🤕 Ärgern',
                            style: filterItemsTextStyle,
                          ),
                          selected: annoyOthers,
                          onSelected: (value) {
                            setState(() {
                              annoyOthers = value;
                            });
                          },
                        ),
                        FilterChip(
                          selectedColor: admonitionReasonChipSelectedColor,
                          checkmarkColor:
                              admonitionReasonChipSelectedCheckColor,
                          backgroundColor: admonitionReasonChipUnselectedColor,
                          label: const Text(
                            '🎓️🙉 Anweisungen ignoriert',
                            style: filterItemsTextStyle,
                          ),
                          selected: ignoreTeacherInstructions,
                          onSelected: (value) {
                            setState(() {
                              ignoreTeacherInstructions = value;
                            });
                          },
                        ),
                        FilterChip(
                          selectedColor: admonitionReasonChipSelectedColor,
                          checkmarkColor:
                              admonitionReasonChipSelectedCheckColor,
                          backgroundColor: admonitionReasonChipUnselectedColor,
                          label: const Text(
                            '🛑🎓️ Stören von Unterricht',
                            style: filterItemsTextStyle,
                          ),
                          selected: disturbLesson,
                          onSelected: (value) {
                            setState(() {
                              disturbLesson = value;
                            });
                          },
                        ),
                        FilterChip(
                          selectedColor: admonitionReasonChipSelectedColor,
                          checkmarkColor:
                              admonitionReasonChipSelectedCheckColor,
                          backgroundColor: admonitionReasonChipUnselectedColor,
                          label: const Text(
                            '📝 Sonstiges',
                            style: filterItemsTextStyle,
                          ),
                          selected: other,
                          onSelected: (value) {
                            setState(() {
                              other = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                style: successButtonStyle,
                onPressed: () {
                  if (admonitionTypeDropdown == 'choose') {
                    informationDialog(context, 'Kein Ereignis ausgewählt',
                        'Bitte eine Ereignis-Art auswählen!');
                    return;
                  }
                  if (violenceAgainstPeople == false &&
                      violenceAgainstThings == false &&
                      annoyOthers == false &&
                      ignoreTeacherInstructions == false &&
                      disturbLesson == false &&
                      other == false) {
                    informationDialog(context, 'Kein Grund ausgewählt',
                        'Bitte mindestens einen Grund auswählen!');
                    return;
                  }
                  postAdmonition(context);
                  Navigator.pop(context);
                },
                child: const Text(
                  'SENDEN',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const Gap(15),
              ElevatedButton(
                style: cancelButtonStyle,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'ABBRECHEN',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the tree

    super.dispose();
  }
}
