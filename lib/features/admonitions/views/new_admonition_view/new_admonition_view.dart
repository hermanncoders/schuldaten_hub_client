import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/schoolday_manager.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/common/widgets/date_picker.dart';
import 'package:schuldaten_hub/features/admonitions/services/admonition_manager.dart';
import 'package:schuldaten_hub/features/goal/services/goal_manager.dart';
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
  final TextEditingController textField1Controller = TextEditingController();
  final TextEditingController textField2Controller = TextEditingController();
  DateTime thisDate = locator<SchooldayManager>().thisDate.value;
  void postAdmonition() async {
    String text1 = textField1Controller.text;
    String text2 = textField2Controller.text;

    await locator<AdmonitionManager>()
        .postAdmonition(widget.pupilId, thisDate, text1, text2);
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
                TextField(
                  minLines: 2,
                  maxLines: 3,
                  controller: textField1Controller,
                  decoration: const InputDecoration(labelText: 'Vorfall-Art'),
                ),
                const Gap(20),
                TextField(
                  minLines: 2,
                  maxLines: 3,
                  controller: textField2Controller,
                  decoration: const InputDecoration(
                      labelText:
                          'Strategien als Hilfe für das Erreichen des Zieles'),
                ),
                const Gap(20),
                InkWell(
                  onTap: () async {
                    final DateTime newDate =
                        await selectDate(context, thisDate);
                    setState(() {
                      thisDate = newDate;
                    });
                  },
                  child: Text(thisDate.formatForUser()),
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[800],
                      minimumSize: const Size.fromHeight(60)),
                  onPressed: () {
                    postAdmonition();
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
    textField1Controller.dispose();
    textField2Controller.dispose();
    super.dispose();
  }
}
