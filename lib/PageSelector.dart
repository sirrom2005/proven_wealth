import 'package:flutter/material.dart';
import 'Api/doGetSplash.dart';
import 'Common/Common.dart';
import 'Common/CommonText.dart';
import 'Models/SplashScreen.dart';
import 'Screens/Login.dart';
import 'Screens/MainScreen.dart';
import 'Services/service_locator.dart';

class PageSelector extends StatefulWidget
{
  static const String id = "pageSelector";

  const PageSelector({Key? key}) : super(key: key);

  @override
  _MyPageSelectorState createState() => _MyPageSelectorState();
}

class _MyPageSelectorState extends State<PageSelector>
{
  getAccountPrefs() async
  {
    var authToken = await Common().getMySaveState(CommonText.loginTokenKey);

    if(authToken.trim().isNotEmpty)
    {
      // await PreLoadData().load(authToken, audioQuality, maxSession);
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil( context, MainScreen.id,ModalRoute.withName('/'));
    }else{
      final splash = await getIt<DoGetSplash>().call();
      getIt<SplashScreen>().filePath = splash.filePath;

      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context, MainScreen.id,
        ModalRoute.withName('/')
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getAccountPrefs();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      const Scaffold(
        body: Center(
          child: SizedBox(
            width:50,
            height: 50,
            child: CircularProgressIndicator(color: Colors.green)
          ),
        )
    );
  }
}