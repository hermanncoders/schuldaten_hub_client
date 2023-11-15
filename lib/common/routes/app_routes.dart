import 'package:schuldaten_hub/features/attendance/views/attendance_view/controller/attendance_list_controller.dart';
import 'package:schuldaten_hub/features/first_level_views/bottom_nav_bar.dart';
import 'package:schuldaten_hub/features/first_level_views/learn_list_view.dart';
import 'package:schuldaten_hub/features/first_level_views/login_view/controller/login_controller.dart';
import 'package:schuldaten_hub/features/first_level_views/scan_tools_view.dart';
import 'package:schuldaten_hub/features/first_level_views/settings_view.dart';

import 'routes.dart';

class AppRoutes {
  static final routes = {
    Routes.login: (context) => const Login(),
    //Routes.loginScan: (context) => const QRScanCredentials(),
    Routes.home: (context) => BottomNavigation(),
    Routes.attendanceList: (context) => const AttendanceList(),
    Routes.learnList: (context) => const LearnListView(),
    Routes.qrTools: (context) => const QrToolsView(),
    //Routes.scanPupils: (context) => const QrScanner(),
    Routes.settings: (context) => const SettingsView()
  };
}
