import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';

BottomAppBar pupilProfileBottomNavBar(BuildContext context) {
  return BottomAppBar(
    padding: const EdgeInsets.all(10),
    shape: null,
    color: backgroundColor,
    child: IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Row(
          children: <Widget>[
            const Spacer(),
            IconButton(
              tooltip: 'zurück',
              icon: const Icon(
                Icons.arrow_back,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const Gap(30),
            IconButton(
                onPressed: () =>
                    Navigator.popUntil(context, (route) => route.isFirst),
                icon: const Icon(
                  Icons.home,
                  size: 30,
                )),
            const Gap(10)

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
    ),
  );
}
