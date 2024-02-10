import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';

BottomAppBar authorizationListBottomNavBar(BuildContext context) {
  return BottomAppBar(
    padding: const EdgeInsets.all(9),
    shape: null,
    color: backgroundColor,
    child: IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
      child: Row(
        children: <Widget>[
          const Spacer(),
          IconButton(
            tooltip: 'zurück',
            icon: const Icon(
              Icons.arrow_back,
              size: 35,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const Gap(30),
          IconButton(
            tooltip: 'Neue Liste',
            icon: const Icon(
              Icons.add,
              size: 35,
            ),
            onPressed: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (ctx) => NewSchoolListView(),
              // ));
            },
          ),
          const Gap(15)
        ],
      ),
    ),
  );
}
