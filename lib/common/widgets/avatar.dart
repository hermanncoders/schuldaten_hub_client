import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:schuldaten_hub/api/endpoints.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/env_manager.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';

Widget avatarImage(Pupil pupil, double size) {
  return SizedBox(
    width: size,
    height: size,
    child: FullScreenWidget(
      disposeLevel: DisposeLevel.Medium,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size / 2),
          child: pupil.avatarUrl != null
              ? Image.network(
                  '${locator<EnvManager>().env.value.serverUrl}${Endpoints().getPupilAvatar(pupil.internalId)}',
                  headers: {
                    "x-access-token":
                        locator<SessionManager>().credentials.value.jwt!
                  },
                )
              : Image.asset(
                  'assets/dummy-profile-pic.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    ),
  );
}

Widget avatarWithBadges(Pupil pupil, double size) {
  return Padding(
    padding: const EdgeInsets.all(11.0),
    child: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: avatarImage(pupil, size),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            width: 30.0,
            height: 30.0,
            decoration: const BoxDecoration(
              color: groupColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                pupil.group!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 30.0,
            height: 30.0,
            decoration: const BoxDecoration(
              color: schoolyearColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                pupil.schoolyear!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        if (pupil.ogs == true)
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 30.0,
              height: 30.0,
              decoration: const BoxDecoration(
                color: ogsColor,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  'OGS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        if (pupil.migrationSupportEnds != null)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 30.0,
              height: 30.0,
              decoration: BoxDecoration(
                color: locator<PupilManager>()
                        .hasLanguageSupport(pupil.migrationSupportEnds)
                    ? Colors.green
                    : Colors.grey,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.language_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    ),
  );
}
