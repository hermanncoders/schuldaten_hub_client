import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';

Future longTextFieldDialog(
    String title, String? textinField, BuildContext parentContext) async {
  return await showDialog(
      context: parentContext,
      builder: (context) {
        return StatefulBuilder(builder: (statefulContext, setState) {
          final TextEditingController textEditingController =
              TextEditingController();
          setState(() {
            textEditingController.text = textinField ?? '';
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
            title: Text(title),
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
                    Navigator.of(parentContext).pop(null);
                    return;
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
              textinField != null
                  ? Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 10.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            minimumSize: const Size.fromHeight(50)),
                        onPressed: () {
                          String newSpecialInformation = '';

                          textEditingController.dispose();
                          Navigator.of(parentContext)
                              .pop(newSpecialInformation);
                        },
                        child: const Text(
                          "LÖSCHEN",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              Padding(
                padding:
                    const EdgeInsets.only(left: 15, right: 15, bottom: 10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: buttonSuccessColor,
                      minimumSize: const Size.fromHeight(50)),
                  onPressed: () {
                    String? newSpecialInformation = textEditingController.text;

                    if (newSpecialInformation.isEmpty) {
                      return;
                    }

                    textEditingController.dispose();
                    Navigator.of(parentContext).pop(newSpecialInformation);
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
