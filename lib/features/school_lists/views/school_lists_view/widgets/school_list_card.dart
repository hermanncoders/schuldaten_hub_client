import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/confirmation_dialog.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/information_dialog.dart';

import 'package:schuldaten_hub/features/school_lists/models/school_list.dart';
import 'package:schuldaten_hub/features/school_lists/services/school_list_manager.dart';

import 'package:schuldaten_hub/features/school_lists/views/school_list_pupils_view/controller/school_list_pupils_controller.dart';

Card schoolListCard(BuildContext context, SchoolList schoolList) {
  return Card(
      child: InkWell(
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => SchoolListPupils(
          schoolList,
        ),
      ));
    },
    onLongPress: () async {
      if (schoolList.createdBy !=
          locator<SessionManager>().credentials.value.username) {
        informationDialog(context, 'Keine Berechtigung',
            'Listen können nur von ListenbesiterInnen bearbeitet werden!');
        return;
      }
      final bool? result = await confirmationDialog(context, 'Liste löschen',
          'Liste "${schoolList.listName}" wirklich löschen?');
      if (result == true) {
        await locator<SchoolListManager>().deleteSchoolList(schoolList.listId);
        if (context.mounted) {
          informationDialog(
              context, 'Liste gelöscht', 'Die Liste wurde gelöscht!');
        }
      }
    },
    borderRadius: BorderRadius.circular(15.0),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 15, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                schoolList.listName,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Gap(5),
              SizedBox(
                width: 250,
                child: Text(
                  schoolList.listDescription,
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const Column(
                children: [],
              )
            ],
          ),
        ),
      ],
    ),
  ));
}
