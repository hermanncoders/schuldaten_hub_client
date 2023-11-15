import 'package:flutter/material.dart';

import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/authorizations/services/authorization_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';

pupilAuthorizationListTiles(Pupil pupil) {
  final authorizationLocator = locator<AuthorizationManager>();
  return ListTileTheme(
    contentPadding: const EdgeInsets.all(0),
    dense: true,
    horizontalTitleGap: 0.0,
    minLeadingWidth: 0,
    child: ExpansionTile(
      tilePadding: const EdgeInsets.all(0),
      title: const Text(
        'Einwilligungen',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      children: [
        ListView.builder(
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: pupil.authorizations!.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: GestureDetector(
                  onTap: () {},
                  onLongPress: () async {},
                  child: ListTile(
                    title: (Text(
                        authorizationLocator
                            .getAuthorization(pupil
                                .authorizations![index].originAuthorization)
                            .authorizationName,
                        style: const TextStyle(fontSize: 18))),
                    subtitle: Text(
                      authorizationLocator
                          .getAuthorization(
                              pupil.authorizations![index].originAuthorization)
                          .authorizationDescription,
                      style: const TextStyle(fontSize: 15),
                    ),
                    trailing: Checkbox(
                      activeColor: Colors.green,
                      value: authorizationLocator
                              .getPupilAuthorization(
                                  pupil.internalId,
                                  pupil.authorizations![index]
                                      .originAuthorization)
                              .status ??
                          false,
                      onChanged: (value) async {
                        await authorizationLocator.patchPupilAuthorization(
                            pupil.internalId,
                            pupil.authorizations![index].originAuthorization,
                            value,
                            null);
                      },
                    ),
                  )),
            );
          },
        ),
      ],
    ),
  );
}
