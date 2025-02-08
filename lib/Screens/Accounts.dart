import 'package:flutter/material.dart';
import 'package:proven_wealth/Screens/AccountHome.dart';
import '../Services/page_manager.dart';
import '../Services/service_locator.dart';
import 'Login.dart';

class Accounts extends StatefulWidget {
  static const String id = "Accounts";
  const Accounts({super.key});

  @override
  Page createState() => Page();
}

class Page extends State<Accounts>{

  @override
  Widget build(BuildContext context) {
    return
      // Scaffold(
      //   backgroundColor: MyColors.appBackGroundColor,
      //   body: LoadingOverlay(
      //       isLoading: false,
      //       progressIndicator: const CircularProgressIndicator(),
      //       child: SafeArea(
      //         child: SingleChildScrollView(
      //             child: Text('Accounts')
      //         ),
      //       )
      //   )
      // );

    MaterialApp(
      title: 'Proven',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Montserrat'),
      initialRoute: Login.id,
      routes: {
        //PageSelector.id: (context) => const PageSelector(),
        Login.id: (context) => const Login(),
        AccountHome.id: (context) => const AccountHome()
      }
    );
  }
}