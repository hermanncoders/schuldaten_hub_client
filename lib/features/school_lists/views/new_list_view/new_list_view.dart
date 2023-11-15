import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/avatar.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/controller/pupil_profile_controller.dart';
import 'package:schuldaten_hub/features/pupil/views/select_pupils_list_view/controller/select_pupils_list_controller.dart';
import 'package:schuldaten_hub/features/school_lists/services/school_list_manager.dart';

class NewSchoolListView extends StatefulWidget {
  const NewSchoolListView({super.key});

  @override
  NewSchoolListViewState createState() => NewSchoolListViewState();
}

class NewSchoolListViewState extends State<NewSchoolListView> {
  final TextEditingController textField1Controller = TextEditingController();
  final TextEditingController textField2Controller = TextEditingController();
  Set<int> pupilIds = {};
  void postNewSchoolList() async {
    String text1 = textField1Controller.text;
    String text2 = textField2Controller.text;

    await locator<SchoolListManager>()
        .postSchoolListWithGroup(text1, text2, pupilIds.toList(), 'private');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text('Neue Liste'),
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
                  decoration:
                      const InputDecoration(labelText: 'Name der Liste'),
                ),
                const Gap(20),
                TextField(
                  minLines: 2,
                  maxLines: 3,
                  controller: textField2Controller,
                  decoration: const InputDecoration(
                      labelText: 'Kurze Beschreibung der Liste'),
                ),
                const Gap(20),
                const Text('Ausgewählte Kinder:'),
                pupilIds.isNotEmpty
                    ? Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: ListView.builder(
                              padding: const EdgeInsets.only(
                                  left: 10, top: 5, bottom: 15),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: locator<PupilManager>()
                                  .pupilsFromPupilIds(pupilIds.toList())
                                  .length,
                              itemBuilder: (context, int index) {
                                Pupil listedPupil = locator<PupilManager>()
                                    .pupilsFromPupilIds(
                                        pupilIds.toList())[index];
                                return Column(
                                  children: [
                                    const Gap(5),
                                    InkWell(
                                      onLongPress: () {
                                        setState(() {
                                          pupilIds
                                              .remove(listedPupil.internalId);
                                        });
                                      },
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (ctx) => PupilProfile(
                                            listedPupil,
                                          ),
                                        ));
                                      },
                                      child: Row(
                                        children: [
                                          avatarImage(listedPupil, 30),
                                          const Gap(10),
                                          Text(
                                            listedPupil.firstName!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const Gap(10),
                                          Text(
                                            listedPupil.lastName!,
                                            style: const TextStyle(),
                                          ),
                                          const Gap(20),
                                          Text(
                                            listedPupil.group!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: groupColor),
                                          ),
                                          const Gap(20),
                                          Text(
                                            listedPupil.schoolyear!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: schoolyearColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ),
                      )
                    : const Text('Keine Kinder ausgewählt'),
                const Spacer(
                  flex: 1,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor,
                      minimumSize: const Size.fromHeight(60)),
                  onPressed: () async {
                    final List<int> selectedPupilIds =
                        await Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const SelectPupilList(),
                            )) ??
                            [];
                    if (selectedPupilIds.isNotEmpty) {
                      setState(() {
                        pupilIds.addAll(selectedPupilIds.toSet());
                      });
                    }
                  },
                  child: const Text(
                    'KINDER AUSWÄHLEN',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Gap(15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[800],
                      minimumSize: const Size.fromHeight(60)),
                  onPressed: () {
                    postNewSchoolList();
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
