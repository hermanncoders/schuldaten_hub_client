import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';

Future specialInformationDialog(
    Pupil pupil, String? specialInformation, BuildContext parentContext) async {
  return await showDialog(
      context: parentContext,
      builder: (context) {
        return StatefulBuilder(builder: (statefulContext, setState) {
          final TextEditingController textEditingController =
              TextEditingController();
          setState(() {
            textEditingController.text = specialInformation ?? '';
          });
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: backgroundColor),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      maxLines: 3,
                      textAlign: TextAlign.start,
                      style: const TextStyle(fontSize: 17),
                      keyboardType: TextInputType.multiline,
                      controller: textEditingController,
                      decoration: null,
                    ),
                  ),
                ),
                const Gap(10),
              ],
            ),
            title: const Text('Besondere Infos ändern'),
            actions: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(left: 15, right: 15, bottom: 10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: buttonDangerColor,
                      minimumSize: const Size.fromHeight(50)),
                  onPressed: () {
                    textEditingController.dispose();
                    Navigator.of(parentContext).pop();
                  },
                  child: const Text(
                    "ABBRECHEN",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 15, right: 15, bottom: 10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size.fromHeight(50)),
                  onPressed: () {
                    String? newSpecialInformation =
                        textEditingController.text == ''
                            ? null
                            : textEditingController.text;

                    locator<PupilManager>().changePupilSpecialInformation(
                        pupil.internalId, newSpecialInformation);

                    textEditingController.dispose();
                    Navigator.of(parentContext).pop();
                  },
                  child: const Text(
                    "OKAY",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
      });
}
