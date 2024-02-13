import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';

BottomAppBar pupilProfileBottomNavBar(BuildContext context) {
  return BottomAppBar(
    padding: const EdgeInsets.only(bottom: 10, right: 10, top: 6),
    shape: null,
    color: backgroundColor,
    child: IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: SizedBox(
          height: 35,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Spacer(),

              const Gap(15),
              IconButton(
                iconSize: 30,
                tooltip: 'zurück',
                icon: const Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Gap(20),
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
    ),
  );
}
