import 'package:schuldaten_hub/common/services/env_manager.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/features/admonitions/services/admonition_manager.dart';
import 'package:schuldaten_hub/features/authorizations/services/authorization_manager.dart';
import 'package:schuldaten_hub/features/competence/services/competence_filter_manager.dart';
import 'package:schuldaten_hub/features/competence/services/competence_manager.dart';
import 'package:schuldaten_hub/api/services/connection_manager.dart';
import 'package:schuldaten_hub/features/goal/services/goal_manager.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';
import 'package:schuldaten_hub/features/pupil/services/pupilbase_manager.dart';
import 'package:schuldaten_hub/features/school_lists/services/school_list_manager.dart';
import 'package:schuldaten_hub/common/services/schoolday_manager.dart';
import 'package:schuldaten_hub/features/first_level_views/bottom_nav_bar.dart';
import 'package:watch_it/watch_it.dart';

import '../../api/services/api_manager.dart';
import '../../features/attendance/services/attendance_manager.dart';
import 'session_manager.dart';

final locator = GetIt.instance;

void registerBaseManagers() {
  debug.info('Registering base managers');
  locator.registerSingletonAsync<EnvManager>(() async {
    debug.info('Registering EnvManager');
    final envManager = EnvManager();
    await envManager.init();
    debug.info('EnvManager initialized');
    return envManager;
  });

  locator.registerSingletonAsync<ConnectionManager>(() async {
    debug.info('Registering ConnectionManager');
    final connectionManager = ConnectionManager();
    await connectionManager.checkConnectivity();
    debug.info('ConnectionManager initialized');
    return connectionManager;
  });

  locator.registerSingletonAsync<SessionManager>(() async {
    debug.info('Registering SessionManager');
    final sessionManager = SessionManager();
    await sessionManager.init();
    debug.info('SessionManager initialized');
    return sessionManager;
  });

  locator.registerSingletonAsync<PupilBaseManager>(() async {
    debug.info('Registering PupilBaseManager');
    final pupilBaseManager = PupilBaseManager();
    await pupilBaseManager.init();
    debug.info('PupilBaseManager initialized');
    return pupilBaseManager;
  });
  locator.registerSingleton<BottomNavManager>(BottomNavManager());
}

void registerDependentManagers(String token) {
  debug.info('Registering dependent managers');

  locator.registerSingletonAsync<ApiManager>(
    () async {
      debug.info('Registering ApiManager');
      final apiManager = ApiManager();
      await apiManager.init(token);
      debug.info('ApiManager initialized');
      return apiManager;
    },
    dependsOn: [EnvManager, SessionManager, ConnectionManager],
  );

  locator.registerSingletonAsync<SchooldayManager>(() async {
    debug.info('Registering SchooldayManager');
    final schooldayManager = SchooldayManager();
    await schooldayManager.init();
    debug.info('SchooldayManager initialized');
    return schooldayManager;
  }, dependsOn: [SessionManager, ApiManager]);

  locator.registerSingletonAsync<SchoolListManager>(() async {
    debug.info('Registering SchoolListManager');
    final schoolListManager = SchoolListManager();
    await schoolListManager.init();
    debug.info('SchoolListManager initialized');
    return schoolListManager;
  }, dependsOn: [SessionManager, ApiManager]);

  locator.registerSingletonAsync<CompetenceManager>(() async {
    debug.info('Registering CompetenceManager');
    final competenceManager = CompetenceManager();
    await competenceManager.init();
    debug.info('CompetenceManager initialized');
    return competenceManager;
  }, dependsOn: [SessionManager, ApiManager]);

  locator.registerSingletonWithDependencies<CompetenceFilterManager>(
    () => CompetenceFilterManager(),
    dependsOn: [CompetenceManager],
  );

  locator.registerSingletonAsync<GoalManager>(() async {
    debug.info('Regirstering GoalManager');
    final goalManager = GoalManager();
    await goalManager.init();
    debug.info('GoalManager initialized');
    return goalManager;
  }, dependsOn: [SessionManager, ApiManager]);

  locator.registerSingletonAsync<AuthorizationManager>(() async {
    debug.info('Registering AuthorizationManager');
    final authorizationManager = AuthorizationManager();
    await authorizationManager.init();
    debug.info('AuthorizarionManager initialized');
    return authorizationManager;
  }, dependsOn: [SessionManager, ApiManager]);

  locator.registerSingletonAsync<PupilManager>(() async {
    debug.info('Registering PupilManager');
    final pupilManager = PupilManager();
    await pupilManager.init();
    debug.info('PupilManager initialized');
    return pupilManager;
  }, dependsOn: [EnvManager, ApiManager, SessionManager, PupilBaseManager]);

  locator.registerSingletonWithDependencies<PupilFilterManager>(
    () => PupilFilterManager(),
    dependsOn: [PupilManager],
  );

  locator.registerLazySingleton<AttendanceManager>(() => AttendanceManager());
  locator.registerLazySingleton<AdmonitionManager>(() => AdmonitionManager());
}
