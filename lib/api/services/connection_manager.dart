import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';

class ConnectionManager {
  ValueListenable<ConnectivityResult> get connectivity => _connectivity;

  final _connectivity =
      ValueNotifier<ConnectivityResult>(ConnectivityResult.none);

  bool get isConnected => _connectivity.value != ConnectivityResult.none;
  ConnectionManager() {
    debug.warning('ConnectionManager initialized');
  }

  Future checkConnectivity() async {
    final connection = await (Connectivity().checkConnectivity());
    _connectivity.value = connection;

    return;
  }
}
