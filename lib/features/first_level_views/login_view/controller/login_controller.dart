import 'dart:convert';

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:schuldaten_hub/common/services/env_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/common/utils/scanner.dart';
import 'package:schuldaten_hub/common/widgets/snackbars.dart';
import 'package:schuldaten_hub/features/first_level_views/loading_page.dart';
import 'package:schuldaten_hub/features/first_level_views/login_view/login_view.dart';
import 'package:watch_it/watch_it.dart';

class Login extends WatchingStatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginController createState() => LoginController();
}

class LoginController extends State<Login> {
  //final Env env = locator<EnvManager>().env.value;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  scanCredentials() async {
    final String? scanResponse = await scanner(context);
    if (scanResponse != null) {
      final loginData = await json.decode(scanResponse);
      final username = loginData['username'];
      final password = loginData['password'];
      attemptLogin(username, password);
    } else {
      if (context.mounted) {
        snackbarWarning(context, 'Scanvorgang abgebrochen');
      }
      return;
    }
  }

  scanEnv() async {
    final String? scanResponse = await scanner(context);
    if (scanResponse != null) {
      locator<EnvManager>().setEnv(scanResponse);
      if (context.mounted) {
        snackbarSuccess(context, 'Schul-Id erfolgreich importiert!');
      }
      return;
    } else {
      if (context.mounted) {
        snackbarWarning(context, 'Scanvorgang abgebrochen');
      }
      return;
    }
  }

  textFieldCredentials() async {
    String username = usernameController.text;
    String password = passwordController.text;
    await attemptLogin(username, password);
  }

  attemptLogin(String username, String password) async {
    bool isAuthenticated =
        await locator<SessionManager>().attemptLogin(username, password);
    if (isAuthenticated == true) {
      if (context.mounted) {
        snackbarSuccess(context, 'Login erfolgreich!');
      }
      debug.success('Is authenticated is $isAuthenticated');
    } else {
      if (context.mounted) {
        snackbarWarning(context, 'Login fehlgeschlagen!');
      }
    }
  }

  importEnvFromTxt() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      String rawTextResult = await file.readAsString();
      locator<EnvManager>().setEnv(rawTextResult);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: locator.allReady(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return LoginView(this);
        } else {
          return const LoadingPage();
        }
      },
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
