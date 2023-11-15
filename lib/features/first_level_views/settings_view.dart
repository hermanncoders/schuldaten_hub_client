import 'package:flutter/material.dart';

import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/models/session_models/session.dart';
import 'package:schuldaten_hub/common/routes/routes.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupilbase_manager.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/common/widgets/qr_view.dart';
import 'package:schuldaten_hub/common/widgets/snackbars.dart';
import 'package:schuldaten_hub/features/first_level_views/bottom_nav_bar.dart';
import 'package:schuldaten_hub/features/pupil/views/select_pupils_list_view/controller/select_pupils_list_controller.dart';

import 'package:schuldaten_hub/features/statistics/statistics_view/controller/statistics.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:watch_it/watch_it.dart';

class SettingsView extends WatchingWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final Session session = watchValue((SessionManager x) => x.credentials);
    final String username = session.username!;
    final int credit = session.credit!;
    final bool isAdmin = session.isAdmin!;

    void logout() async {
      await locator<SessionManager>().logout();

      locator.get<BottomNavManager>().setBottomNavPage(0);
      if (context.mounted) {
        snackbarSuccess(context, 'Zugangsdaten und QR-Ids gelöscht!');
        await Navigator.of(context).pushNamed(Routes.login);
      }
    }

    return Scaffold(
      backgroundColor: canvasColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: const Text('Einstellungen'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: SettingsList(
            contentPadding: const EdgeInsets.only(top: 10),
            sections: [
              SettingsSection(
                title: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Session',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                tiles: <SettingsTile>[
                  SettingsTile.navigation(
                    title: const Text('Angemeldet als'),
                    value: Text(username),
                    trailing: null,
                  ),
                  SettingsTile.navigation(
                    title: const Text('Guthaben'),
                    value: Text(credit.toString()),
                  ),
                  SettingsTile.navigation(
                    leading: GestureDetector(
                        onTap: logout, child: const Icon(Icons.logout)),
                    title: const Text('Ausloggen'),
                    value: const Text('QR-IDs bleiben erhalten'),
                    //onPressed:
                  ),
                  SettingsTile.navigation(
                    leading: const Icon(Icons.delete_forever_outlined),
                    title: const Text('Lokale ID-Schlüssel löschen'),
                    onPressed: (context) =>
                        locator.get<PupilBaseManager>().deleteData(),
                    value: const Text('QR-IDs löschen'),
                    //onPressed:
                  ),
                ],
              ),
              SettingsSection(
                title: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Tools',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                tiles: <SettingsTile>[
                  SettingsTile.navigation(
                    title: const Text('Statistik-Zahlen ansehen'),
                    onPressed: (context) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => const Statistics(),
                      ));
                    },
                  ),
                  isAdmin == true
                      ? SettingsTile.navigation(
                          title: const Text('Kinder QR-Ids zeigen'),
                          onPressed: (context) async {
                            final List<int> pupilIds =
                                await Navigator.of(context)
                                    .push(MaterialPageRoute(
                              builder: (ctx) => const SelectPupilList(),
                            ));
                            if (pupilIds.isEmpty) {
                              return;
                            }
                            final String qr = await locator<PupilBaseManager>()
                                .generatePupilBaseQrData(pupilIds);

                            if (context.mounted) {
                              await showQrCode(qr, context);
                            }
                          })
                      : SettingsTile.navigation(title: const Text('nur Admin'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
