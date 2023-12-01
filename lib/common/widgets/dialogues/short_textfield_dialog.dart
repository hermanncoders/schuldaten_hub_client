import 'package:flutter/material.dart';

shortTextfieldDialog(BuildContext context, String title, String labelText) {
  TextEditingController textEditingController = TextEditingController();

  return showDialog<String?>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: TextField(
          controller: textEditingController,
          //maxLength: 16,
          decoration: const InputDecoration(
            border: InputBorder.none,
            labelText: 'Passwort eingeben',
          ),
          obscureText: true,
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Abbrechen'),
            onPressed: () {
              textEditingController.dispose();
              Navigator.of(context).pop(null);
            },
          ),
          ElevatedButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop(textEditingController.text);
            },
          ),
        ],
      );
    },
  );
}
