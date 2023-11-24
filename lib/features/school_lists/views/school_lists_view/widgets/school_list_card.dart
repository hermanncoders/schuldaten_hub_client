import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:schuldaten_hub/features/school_lists/models/school_list.dart';

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
