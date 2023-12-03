import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/models/session_models/session.dart';
import 'package:schuldaten_hub/common/routes/routes.dart';
import 'package:schuldaten_hub/common/services/env_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/confirmation_dialog.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/short_textfield_dialog.dart';
import 'package:schuldaten_hub/features/pupil/services/pupilbase_manager.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/common/widgets/qr_view.dart';
import 'package:schuldaten_hub/common/widgets/snackbars.dart';
import 'package:schuldaten_hub/features/pupil/views/select_pupils_list_view/controller/select_pupils_list_controller.dart';

import 'package:schuldaten_hub/features/statistics/statistics_view/controller/statistics.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:watch_it/watch_it.dart';

class SettingsView extends WatchingWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final Session session = watchValue((SessionManager x) => x.credentials);
    final int credit = session.credit!;
    final String username = session.username!;

    final bool isAdmin = session.isAdmin!;

    void logout() async {
      await locator<SessionManager>().logout();

      if (context.mounted) {
        snackbarSuccess(context, 'Zugangsdaten und QR-Ids gelöscht!');
        await Navigator.of(context).pushNamed(Routes.login);
      }
    }

    void logoutAndDeleteAllData() async {
      await locator<PupilBaseManager>().deleteData();
      await locator<EnvManager>().deleteEnv();
      await locator<SessionManager>().logout();

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
                    leading: const Icon(
                      Icons.account_circle_rounded,
                    ),
                    title: const Text('Angemeldet als'),
                    value: Text(
                      username,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: null,
                  ),
                  SettingsTile.navigation(
                    leading: const Icon(Icons.attach_money_rounded),
                    title: const Text('Guthaben'),
                    value: Text(
                      credit.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SettingsTile.navigation(
                    leading: const Icon(Icons.punch_clock_rounded),
                    title: const Text('Token gültig noch:'),
                    value: Text(
                      locator<SessionManager>()
                          .tokenLifetimeLeft(session.jwt!)
                          .toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SettingsTile.navigation(
                    leading: InkWell(
                        onTap: () async {
                          try {
                            final String? password = await shortTextfieldDialog(
                                context, 'Token erneuern', 'Passwort');
                            if (password == null) {
                              return;
                            }

                            int success = await locator<SessionManager>()
                                .refreshToken(password);

                            if (success == 401 && context.mounted) {
                              snackbarError(context, 'Falsches Passwort');
                              return;
                            } else if (success == 200 && context.mounted) {
                              snackbarSuccess(context, 'Token erneuert!');
                            }
                          } catch (e) {
                            snackbarError(context, 'Unbekannter Fehler');
                          }
                        },
                        child: const Icon(Icons.password_rounded)),
                    title: const Text('Token erneuern'),
                  ),
                  SettingsTile.navigation(
                    leading: GestureDetector(
                        onTap: logout, child: const Icon(Icons.logout)),
                    title: const Text('Ausloggen'),
                    value: const Text('Daten bleiben erhalten'),
                    //onPressed:
                  ),
                  SettingsTile.navigation(
                    leading: GestureDetector(
                        onTap: () async {
                          bool? confirm = await confirmationDialog(context,
                              'Achtung!', 'Ausloggen und alle Daten löschen?');
                          if (confirm == true) {
                            logoutAndDeleteAllData();
                          }
                          return;
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.logout),
                            Gap(5),
                            Icon(Icons.delete_forever_outlined)
                          ],
                        )),
                    title: const Text('Ausloggen und Daten löschen'),
                    value: const Text('App wird zurückgesetzt!'),
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
                    leading: const Icon(Icons.bar_chart_rounded),
                    title: const Text('Statistik-Zahlen ansehen'),
                    onPressed: (context) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => const Statistics(),
                      ));
                    },
                  ),
                  SettingsTile.navigation(
                      leading: const Icon(Icons.qr_code_rounded),
                      title: const Text('Kinder QR-Ids zeigen'),
                      onPressed: (context) async {
                        final List<int> pupilIds =
                            await Navigator.of(context).push(MaterialPageRoute(
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
