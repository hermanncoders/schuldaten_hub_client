import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:schuldaten_hub/common/models/session_models/env.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/common/utils/secure_storage.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/first_level_views/bottom_nav_bar.dart';

class EnvManager {
  ValueListenable<Env> get env => _env;
  ValueListenable<bool> get envReady => _envReady;
  ValueListenable<PackageInfo> get packageInfo => _packageInfo;

  final _env = ValueNotifier<Env>(Env());
  final _envReady = ValueNotifier<bool>(false);
  final _packageInfo = ValueNotifier<PackageInfo>(PackageInfo(
    appName: '',
    packageName: '',
    version: '',
    buildNumber: '',
    buildSignature: '',
  ));

  EnvManager();
  Future<EnvManager> init() async {
    debug.warning('EnvManager initializing!');
    await checkStoredEnv();
    debug.warning('returning EnvManager!');
    return this;
  }

  Future<void> checkStoredEnv() async {
    bool isStoredEnv = await secureStorageContains('env');
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _packageInfo.value = packageInfo;
    if (isStoredEnv == true) {
      final String? storedSession = await secureStorageRead('env');
      debug.success('env found!');
      try {
        final env = Env.fromJson(
          json.decode(storedSession!) as Map<String, dynamic>,
        );
        _env.value = env;
        _envReady.value = true;

        return;
      } catch (e) {
        debug.error(
          'Error reading env from secureStorage: $e | ${StackTrace.current}',
        );
        await secureStorageDelete('env');

        return;
      }
    } else {
      debug.info('No env found');

      return;
    }
  }

  // set the environment from a string
  void setEnv(String scanResult) async {
    final Env env =
        Env.fromJson(json.decode(scanResult) as Map<String, dynamic>);
    _env.value = env;
    _envReady.value = true;
    final jsonEnv = json.encode(env.toJson());
    await secureStorageWrite('env', jsonEnv);
    debug.success('Env stored');
    debug.success(jsonEnv);
    return;
  }

  deleteEnv() async {
    _env.value = Env();
    _envReady.value = false;
    await secureStorageDelete('env');
    //await secureStorageDelete('pupilBase');
    locator.get<BottomNavManager>().setBottomNavPage(0);
  }
}
