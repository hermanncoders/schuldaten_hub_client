import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';

BottomAppBar pupilProfileBottomNavBar(BuildContext context) {
  return BottomAppBar(
    padding: const EdgeInsets.all(9),
    shape: const CircularNotchedRectangle(),
    color: backgroundColor,
    child: IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
      child: Row(
        children: <Widget>[
          IconButton(
            tooltip: 'Open navigation menu',
            icon: const Icon(
              Icons.arrow_back,
              size: 35,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const Spacer(),
          IconButton(
              onPressed: () =>
                  Navigator.popUntil(context, (route) => route.isFirst),
              icon: const Icon(
                Icons.home,
                size: 35,
              )),

          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(Icons.check_circle_rounded),
          // ),
          // IconButton(
          //   tooltip: 'Search',
          //   icon: const Icon(Icons.list_alt_rounded),
          //   onPressed: () {},
          // ),
          // IconButton(
          //   tooltip: 'Search',
          //   icon: const Icon(Icons.translate_rounded),
          //   onPressed: () {},
          // ),
          // IconButton(
          //   tooltip: 'Favorite',
          //   icon: const Icon(Icons.info_rounded),
          //   onPressed: () {},
          // ),
        ],
      ),
    ),
  );
}
