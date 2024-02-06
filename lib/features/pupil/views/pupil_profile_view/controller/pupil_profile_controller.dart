import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/services/locator.dart';

import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/pupil_profile_view.dart';

class PupilProfile extends StatefulWidget {
  final Pupil pupil;

  const PupilProfile(
    this.pupil, {
    Key? key,
  }) : super(key: key);

  @override
  PupilProfileController createState() => PupilProfileController();
}

class PupilProfileController extends State<PupilProfile> {
  deleteAvatar() async {
    await locator<PupilManager>().deleteAvatarImage(
        widget.pupil.internalId, widget.pupil.internalId.toString()!);
  }

  @override
  Widget build(BuildContext context) {
    return PupilDetailsView(this);
  }
}
