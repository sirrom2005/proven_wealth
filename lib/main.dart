import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'PageSelector.dart';
import 'Screens/Login.dart';
import 'Screens/Profile.dart';
import 'Screens/MainScreen.dart';
import 'Services/service_locator.dart';

Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  //FireBaseApi().setupFlutterNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      return MaterialApp(
        title: 'Proven',
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Montserrat'),
        home: const MainScreen(),
        // initialRoute: MainScreen.id,
        // routes: {
        //   //PageSelector.id: (context) => const PageSelector(),
        //   Login.id: (context) => const Login(),
        //   MainScreen.id: (context) => const MainScreen(),
        //   Profile.id: (context) => const Profile()
        // }
      );
  }
}