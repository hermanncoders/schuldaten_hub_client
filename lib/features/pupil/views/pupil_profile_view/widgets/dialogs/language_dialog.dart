import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/common/services/locator.dart';

import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';

// based on https://mobikul.com/creating-stateful-dialog-form-in-flutter/

Future<void> languageDialog(
    BuildContext context, Pupil pupil, String type, String? value) async {
  String languageValue = value ?? '000';

  return await showDialog(
      context: context,
      builder: (context) {
        String dropdownUnderstandValue = languageValue.substring(0, 1);
        String dropdownSpeakValue = languageValue.substring(1, 2);
        String dropdownReadValue = languageValue.substring(2, 3);

        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            content: Form(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.hearing),
                      const Gap(5),
                      const Text("Versteht: ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          )),
                      const Gap(5),
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            onTap: () {
                              FocusManager.instance.primaryFocus!.unfocus();
                            },
                            value: dropdownUnderstandValue,
                            items: const [
                              DropdownMenuItem(
                                  value: '0',
                                  child: Center(
                                    child: Text("nicht",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        )),
                                  )),
                              DropdownMenuItem(
                                  value: '1',
                                  child: Center(
                                    child: Text("einfache Anliegen",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        )),
                                  )),
                              DropdownMenuItem(
                                  value: '2',
                                  child: Center(
                                    child: Text("komplexere Informationen",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        )),
                                  )),
                              DropdownMenuItem(
                                  value: '3',
                                  child: Center(
                                    child: Text("ohne Probleme",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        )),
                                  )),
                              DropdownMenuItem(
                                  value: '4',
                                  child: Center(
                                    child: Text("unbekannt",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        )),
                                  )),
                            ],
                            onChanged: (newvalue) {
                              setState(() {
                                dropdownUnderstandValue = newvalue!;
                              });
                            }),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.chat_bubble_outline_rounded),
                      const Gap(5),
                      const Text("spricht: ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          )),
                      const Gap(5),
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            onTap: () {
                              FocusManager.instance.primaryFocus!.unfocus();
                            },
                            value: dropdownSpeakValue,
                            items: const [
                              DropdownMenuItem(
                                  value: '0',
                                  child: Center(
                                    child: Text("nicht",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        )),
                                  )),
                              DropdownMenuItem(
                                  value: '1',
                                  child: Center(
                                    child: Text("einfache Anliegen",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        )),
                                  )),
                              DropdownMenuItem(
                                  value: '2',
                                  child: Center(
                                    child: Text("komplexere Informationen",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        )),
                                  )),
                              DropdownMenuItem(
                                  value: '3',
                                  child: Center(
                                    child: Text("ohne Probleme",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        )),
                                  )),
                              DropdownMenuItem(
                                  value: '4',
                                  child: Center(
                                    child: Text("unbekannt",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        )),
                                  )),
                            ],
                            onChanged: (newvalue) {
                              setState(() {
                                dropdownSpeakValue = newvalue!;
                              });
                            }),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.book),
                      const Gap(5),
                      const Text("liest: ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          )),
                      const Gap(5),
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            onTap: () {
                              FocusManager.instance.primaryFocus!.unfocus();
                            },
                            value: dropdownReadValue,
                            items: const [
                              DropdownMenuItem(
                                  value: '0',
                                  child: Center(
                                    child: Text("nicht",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        )),
                                  )),
                              DropdownMenuItem(
                                  value: '1',
                                  child: Center(
                                    child: Text("einfache Anliegen",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        )),
                                  )),
                              DropdownMenuItem(
                                  value: '2',
                                  child: Center(
                                    child: Text("komplexere Informationen",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        )),
                                  )),
                              DropdownMenuItem(
                                  value: '3',
                                  child: Center(
                                    child: Text("ohne Probleme",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        )),
                                  )),
                              DropdownMenuItem(
                                  value: '4',
                                  child: Center(
                                    child: Text("unbekannt",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        )),
                                  )),
                            ],
                            onChanged: (newvalue) {
                              setState(() {
                                dropdownReadValue = newvalue!;
                              });
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            )),
            title: const Text('Kommunikation auf Deutsch'),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: InkWell(
                  child: const Text(
                    'ABBRECHEN',
                    style: TextStyle(
                        color: accentColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () async {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: InkWell(
                  child: const Text(
                    'OK',
                    style: TextStyle(
                        color: accentColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    final String communicationValue = dropdownUnderstandValue +
                        dropdownSpeakValue +
                        dropdownReadValue;
                    locator<PupilManager>().patchCommunicationValue(
                        pupil.internalId, type, communicationValue);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          );
        });
      });
}
