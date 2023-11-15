import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';

BottomAppBar schoolListPupilsBottomNavBar(BuildContext context) {
  return BottomAppBar(
    padding: const EdgeInsets.all(9),
    shape: null,
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
          // IconButton(
          //   tooltip: 'Search',
          //   icon: const Icon(Icons.search),
          //   onPressed: () {},
          // ),
          // IconButton(
          //   tooltip: 'Favorite',
          //   icon: const Icon(Icons.favorite),
          //   onPressed: () {},
          // ),
        ],
      ),
    ),
  );
}
