import 'package:get_it/get_it.dart';
import 'package:proven_wealth/Services/page_manager.dart';
import '../Api/doGetSplash.dart';
import '../Models/ChartData.dart';
import '../Models/LoginSession.dart';
import '../Models/Profile.dart';
import '../Models/SplashScreen.dart';

GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async
{
  //getIt.registerLazySingleton<List<ChartData>>(() => []);

  //API DoGetProgrammeList
  getIt.registerLazySingleton<DoGetSplash>(() => DoGetSplash());
  //getIt.registerLazySingleton<DoGetProfile>(() => DoGetProfile());
  //getIt.registerLazySingleton<DoGetSchedulesList>(() => DoGetSchedulesList());
  getIt.registerLazySingleton<LoginSession>(() => LoginSession(authToken: '', audioQuality: [], maxSession: 0));

  getIt.registerLazySingleton<SplashScreen>(() => SplashScreen(id:0, filePath:'', action: '', published: false));
  getIt.registerLazySingleton<Profile>;

  // services
  // getIt.registerLazySingleton<PlaylistRepository>(() => RadioPlaylist());
  // getIt.registerSingleton<AudioHandler>(await initAudioService());
  getIt.registerLazySingleton<PageManager>(() => PageManager());
}
