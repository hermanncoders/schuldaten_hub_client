import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/env_manager.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/features/first_level_views/bottom_nav_bar.dart';
import 'package:schuldaten_hub/features/first_level_views/login_view/controller/login_controller.dart';

import 'package:watch_it/watch_it.dart';

class LoginView extends WatchingWidget {
  final LoginController controller;
  const LoginView(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isAuthenticated = watchValue((SessionManager x) => x.isAuthenticated);
    bool envReady = watchValue((EnvManager x) => x.envReady);

    debug.warning('LoginView: isAuthenticated: ${isAuthenticated.toString()}');
    final bool keyboardOn = MediaQuery.of(context).viewInsets.vertical > 0.0;
    //FocusScopeNode currentFocus = FocusScope.of(context);

    return (envReady && isAuthenticated)
        ? BottomNavigation()
        : Scaffold(
            resizeToAvoidBottomInset: true,
            body: Container(
              color: const Color.fromRGBO(74, 76, 161, 1),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 380),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: keyboardOn
                              ? const EdgeInsets.only(top: 70)
                              : Platform.isWindows
                                  ? const EdgeInsets.only(top: 0)
                                  : const EdgeInsets.only(top: 0)),
                      keyboardOn
                          ? const SizedBox.shrink()
                          : const SizedBox(
                              height: 250,
                              width: 250,
                              child: Image(
                                image:
                                    AssetImage('assets/foreground_windows.png'),
                              ),
                            ),
                      const Gap(20),
                      const Text(
                        "Schuldaten Hub",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      keyboardOn
                          ? const SizedBox(
                              height: 15,
                            )
                          : const SizedBox(
                              height: 30,
                            ),
                      if (envReady) ...<Widget>[
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 380),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 8),
                            child: TextField(
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              controller: controller.usernameController,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'Benutzername',
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Color.fromRGBO(74, 76, 161, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 380),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 8),
                            child: TextField(
                              textDirection: null,
                              controller: controller.passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'Passwort',
                                labelStyle: TextStyle(
                                  color: Color.fromRGBO(74, 76, 161, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            //margin: const EdgeInsets.only(bottom: 16),
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: buttonAppStyleColor,
                                  minimumSize: const Size.fromHeight(50)),
                              onPressed: () async {
                                // locator<EnvManager>().deleteEnv();
                                await controller.textFieldCredentials();
                              },
                              child: const Text(
                                "EINLOGGEN",
                                style: TextStyle(fontSize: 17.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                      if (envReady == false) ...<Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Center(
                            child: Platform.isWindows
                                ? const Text(
                                    'Schul-ID importieren, um fortfahren zu können.',
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  )
                                : const Text(
                                    'Schul-ID scannen, um fortfahren zu können.',
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                      const Gap(20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          //margin: const EdgeInsets.only(bottom: 16),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.amber[800],
                                  minimumSize: const Size.fromHeight(50)),
                              onPressed: () async {
                                envReady
                                    ? controller.scanCredentials()
                                    : Platform.isWindows
                                        ? controller.importEnvFromTxt()
                                        : controller.scanEnv();
                              },
                              child: Platform.isWindows
                                  ? const Text(
                                      'DATEI AUSWÄHLEN',
                                      style: TextStyle(fontSize: 17.0),
                                    )
                                  : const Text(
                                      "SCANNEN",
                                      style: TextStyle(fontSize: 17.0),
                                    )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
