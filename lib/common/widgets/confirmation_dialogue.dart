import 'package:flutter/material.dart';

Future<bool?> showConfirmationDialog(
    BuildContext context, String title, String message) async {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Abbrechen'),
            onPressed: () {
              Navigator.of(context)
                  .pop(false); // Return false to indicate cancellation
            },
          ),
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(context)
                  .pop(true); // Return true to indicate confirmation
            },
          ),
        ],
      );
    },
  );
}
