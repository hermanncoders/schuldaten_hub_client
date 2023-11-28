import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/schoolday_manager.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/common/widgets/date_picker.dart';
import 'package:schuldaten_hub/common/widgets/display_dialog.dart';
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
  bool other = false;
  Color admonitionReasonChipUnselectedColor = Color.fromARGB(255, 248, 162, 93);
  Color admonitionReasonChipSelectedColor = Color.fromARGB(255, 239, 137, 13);
  Color admonitionReasonChipSelectedCheckColor =
      const Color.fromARGB(255, 249, 56, 56);
  DateTime thisDate = locator<SchooldayManager>().thisDate.value;
  String _getDropdownItemText(String value) {
    switch (value) {
      case 'choose':
        return 'bitte wählen';
      case 'rk':
        return 'rote Karte';
      case 'rkogs':
        return 'rote Karte - OGS';
      case 'other':
        return 'sonstiges';
      default:
        return '';
    }
  }

  void postAdmonition(BuildContext context) async {
    String admonitionReason = '';
    if (violenceAgainstPeople == true) {
      admonitionReason = '${admonitionReason}gm';
    }
    if (violenceAgainstThings == true) {
      admonitionReason = '${admonitionReason}gs';
    }
    if (annoyOthers == true) {
      admonitionReason = '${admonitionReason}äa';
    }
    if (ignoreTeacherInstructions == true) {
      admonitionReason = '${admonitionReason}il';
    }
    if (disturbLesson == true) {
      admonitionReason = '${admonitionReason}us';
    }
    if (other == true) {
      admonitionReason = '${admonitionReason}ss';
    }
    await locator<AdmonitionManager>().postAdmonition(
        widget.pupilId, thisDate, admonitionTypeDropdown, admonitionReason);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text('Neuer Vorfall'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    const Text('Vorfall: ', style: title),
                    const Gap(10),
                    DropdownButton<String>(
                      underline: Container(),
                      style: subtitle,
                      value: admonitionTypeDropdown,
                      onChanged: (String? newValue) {
                        setState(() {
                          admonitionTypeDropdown = newValue!;
                        });
                      },
                      items: <String>['choose', 'rk', 'rkogs', 'other']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            _getDropdownItemText(value),
                          ),
                        );
                      }).toList(),
                    ),
                    const Gap(10),
                    const Text('am', style: subtitle),
                    const Gap(10),
                    Row(
                      children: [
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
                  ],
                ),
                const Gap(20),
                Wrap(
                  spacing: 5,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: FilterChip(
                        selectedColor: admonitionReasonChipSelectedColor,
                        checkmarkColor: admonitionReasonChipSelectedCheckColor,
                        backgroundColor: admonitionReasonChipUnselectedColor,
                        label: const Text(
                          'Gewalt gegen Menschen',
                          style: filterItemsTextStyle,
                        ),
                        selected: violenceAgainstPeople,
                        onSelected: (value) {
                          setState(() {
                            violenceAgainstPeople = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: FilterChip(
                        selectedColor: admonitionReasonChipSelectedColor,
                        checkmarkColor: admonitionReasonChipSelectedCheckColor,
                        backgroundColor: admonitionReasonChipUnselectedColor,
                        label: const Text(
                          'Gewalt gegen Sachen',
                          style: filterItemsTextStyle,
                        ),
                        selected: violenceAgainstThings,
                        onSelected: (value) {
                          setState(() {
                            violenceAgainstThings = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: FilterChip(
                        selectedColor: admonitionReasonChipSelectedColor,
                        checkmarkColor: admonitionReasonChipSelectedCheckColor,
                        backgroundColor: admonitionReasonChipUnselectedColor,
                        label: const Text(
                          'Ärgern',
                          style: filterItemsTextStyle,
                        ),
                        selected: annoyOthers,
                        onSelected: (value) {
                          setState(() {
                            annoyOthers = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: FilterChip(
                        selectedColor: admonitionReasonChipSelectedColor,
                        checkmarkColor: admonitionReasonChipSelectedCheckColor,
                        backgroundColor: admonitionReasonChipUnselectedColor,
                        label: const Text(
                          'Anweisungen ignoriert',
                          style: filterItemsTextStyle,
                        ),
                        selected: ignoreTeacherInstructions,
                        onSelected: (value) {
                          setState(() {
                            ignoreTeacherInstructions = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: FilterChip(
                        selectedColor: admonitionReasonChipSelectedColor,
                        checkmarkColor: admonitionReasonChipSelectedCheckColor,
                        backgroundColor: admonitionReasonChipUnselectedColor,
                        label: const Text(
                          'Stören von Unterricht',
                          style: filterItemsTextStyle,
                        ),
                        selected: disturbLesson,
                        onSelected: (value) {
                          setState(() {
                            disturbLesson = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: FilterChip(
                        selectedColor: admonitionReasonChipSelectedColor,
                        checkmarkColor: admonitionReasonChipSelectedCheckColor,
                        backgroundColor: admonitionReasonChipUnselectedColor,
                        label: const Text(
                          'Sonstiges',
                          style: filterItemsTextStyle,
                        ),
                        selected: other,
                        onSelected: (value) {
                          setState(() {
                            other = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const Gap(15),
                const Row(children: [
                  Text(
                    'Bearbeitet: ',
                    style: subtitle,
                  )
                ]),
                const Gap(20),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[800],
                      minimumSize: const Size.fromHeight(60)),
                  onPressed: () {
                    if (admonitionTypeDropdown == 'choose') {
                      informationDialog(
                          context,
                          'Keine Vorfall-Kategorie ausgewählt',
                          'Bitte waehle eine Kategorie aus!');
                      return;
                    }
                    if (violenceAgainstPeople == false &&
                        violenceAgainstThings == false &&
                        annoyOthers == false &&
                        ignoreTeacherInstructions == false &&
                        disturbLesson == false &&
                        other == false) {
                      informationDialog(context, 'Keine Vorfall-Art ausgewählt',
                          'Bitte waehle mindestens eine Eigenschaft aus!');
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
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 235, 67, 67),
                      minimumSize: const Size.fromHeight(60)),
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
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the tree

    super.dispose();
  }
}
