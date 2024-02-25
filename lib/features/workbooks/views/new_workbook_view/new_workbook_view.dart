import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/utils/scanner.dart';
import 'package:schuldaten_hub/common/widgets/snackbars.dart';

import 'package:schuldaten_hub/features/workbooks/services/workbook_manager.dart';

class NewWorkbookView extends StatefulWidget {
  const NewWorkbookView({super.key});

  @override
  NewWorkbookViewState createState() => NewWorkbookViewState();
}

class NewWorkbookViewState extends State<NewWorkbookView> {
  final TextEditingController textField1Controller = TextEditingController();
  final TextEditingController textField2Controller = TextEditingController();
  final TextEditingController textField3Controller = TextEditingController();
  final TextEditingController textField4Controller = TextEditingController();
  Set<int> pupilIds = {};
  void postNewWorkbook() async {
    String workbookName = textField1Controller.text;
    int workbookIsbn = int.parse(textField2Controller.text);
    String workbookSubject = textField3Controller.text;
    String workbookLevel = textField4Controller.text;
    await locator<WorkbookManager>().postWorkbook(
        workbookName, workbookIsbn, workbookSubject, workbookLevel);
    if (context.mounted) {
      snackbarSuccess(context, 'Neues Arbeitsheft erstellt!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text('Neues Arbeitsheft'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  minLines: 2,
                  maxLines: 3,
                  controller: textField1Controller,
                  decoration:
                      const InputDecoration(labelText: 'Name des Heftes'),
                ),
                const Gap(20),
                TextField(
                  minLines: 2,
                  maxLines: 3,
                  controller: textField2Controller,
                  decoration: const InputDecoration(labelText: 'Isbn'),
                ),
                const Gap(10),
                TextField(
                  minLines: 2,
                  maxLines: 3,
                  controller: textField3Controller,
                  decoration: const InputDecoration(labelText: 'Fach'),
                ),
                TextField(
                  minLines: 2,
                  maxLines: 3,
                  controller: textField4Controller,
                  decoration:
                      const InputDecoration(labelText: 'Kompetenzstufe'),
                ),
                const Spacer(),
                ElevatedButton(
                  style: actionButtonStyle,
                  onPressed: () async {
                    final String? scannedIsbn = await scanner(context);
                    if (scannedIsbn == null) {
                      return;
                    }

                    setState(() {
                      textField2Controller.text = scannedIsbn;
                    });
                  },
                  child: const Text(
                    'ISBN SCANNEN',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Gap(15),
                ElevatedButton(
                  style: successButtonStyle,
                  onPressed: () {
                    postNewWorkbook();
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
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the tree
    textField1Controller.dispose();
    textField2Controller.dispose();
    super.dispose();
  }
}
