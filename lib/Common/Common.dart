import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../Api/doLogin.dart';
import '../Classes/AppAction.dart';
import '../Models/LoginSession.dart';
import '../Models/Response.dart';
import '../Models/SplashScreen.dart';
import '../Services/page_manager.dart';
import '../Services/service_locator.dart';
import 'CommonText.dart';
import 'MyColors.dart';
import 'MyStyles.dart';

class Common
{
  //Display pop with upgrade message
  displayUpgradePlan(BuildContext context) async
  {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext c) {
        return
          AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            backgroundColor: MyColors.boxGround,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 11, 11, 0),
                    child: InkWell(
                      onTap:(){ Navigator.of(context).pop(); },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: MyColors.boxGround,
                          borderRadius:BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child:Text('X', style:TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                            //Icon(Icons.favorite, color:Colors.white, size: 23),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 20),
                  child: Text('Please upgrade to a\npaid plan to access this feature', textAlign: TextAlign.center, style:MyStyles.headerStyle1.copyWith(fontSize:12, height:2)),
                ),
                //const SizedBox(height:20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 20),
                  child: Text('Upgrade to get instant access to', textAlign: TextAlign.center, style:MyStyles.headerStyle1.copyWith(fontSize:11, height:2)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                  child: Text('High Quality Audio\nPre-Recorded Content\nFavoriting Programs', textAlign: TextAlign.center, style:MyStyles.headerStyle2.copyWith(fontSize:12, height:2)),
                )
              ],
            ),
            /*actions: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 35, 10, 0),
                child: MyPostButton(text: 'Upgrade', colorStyle:4, onPressed:(){ Navigator.of(context).pop(); }, icon:true,),
              ),
            ],*/
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            elevation: 24
          );
      },
    );
  }

  displayPopUp(BuildContext context, String message, [error=false]) async {
    if(message.isEmpty) return false;
    Size size = MediaQuery.of(context).size;
    double safePaddingTop = MediaQuery.of(context).padding.top;
    double screenHeight = size.height-safePaddingTop;

    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation:0,
      duration: const Duration(seconds:3),
      margin: EdgeInsets.only(bottom:screenHeight-80, left:10, right:10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
        side: BorderSide(color: error ? MyColors.formError : Colors.white)
      ),
      backgroundColor:error ? MyColors.formError : Colors.white,
      content: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(message, style: TextStyle(color: error ? Colors.white : Colors.black), textAlign: TextAlign.center,),
      )
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  displayFavPopUp(BuildContext context, String message) async {
    if(message.isEmpty) return false;
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double offset = Platform.isIOS ? 70 : 35 ;
    double safePaddingTop = WidgetsBinding.instance.window.padding.top + offset;

    final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        elevation:0,
        duration: const Duration(seconds:1),
        margin: EdgeInsets.only(bottom:screenHeight-safePaddingTop, left:20, right:20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: const BorderSide(color:MyColors.boxGround)
        ),
        backgroundColor:MyColors.boxGround,
        content: Padding(
          padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
          child: Row(
            children: [
              Icon(Icons.favorite, color:MyColors.green, size: MyStyles.favoriteIconSize),
              const SizedBox(width:10),
              Expanded(child: Text(message, style: MyStyles.mediumTextStyle2.copyWith(fontSize:MyStyles.fontSize14-3), overflow: TextOverflow.ellipsis)),
            ],
          ),
        )
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  final textStyle = const TextStyle(color: Colors.black, fontSize: 16, fontWeight:FontWeight.normal);

  Future<void> noProfileAlertBox(BuildContext context, Function onPressed ) async {
      return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext c) {
        return
          AlertDialog(
              title: const Align(
                alignment: Alignment.center,
                child: Text('Plan Required!',style: TextStyle(fontSize:15, fontWeight: FontWeight.bold)),
              ),
              content: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      style: textStyle,
                      text: 'Please visit our website\n'
                    ),
                    TextSpan(
                      style: textStyle.copyWith( color: MyColors.green, fontWeight:FontWeight.w500),
                      text: CommonText.websiteLink,
                    ),
                    TextSpan(
                      style: textStyle,
                      text: ' and subscribe to a plan'
                    ),
                  ],
                )
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: MyColors.boxGround,
                      borderRadius:BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child: MaterialButton(
                      child: const Text('Close', style: TextStyle(color: Colors.white, fontFamily: 'Rustica')),
                      onPressed: () {
                        onPressed.call();
                      },
                    ),
                  ),
                ),
              ],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              elevation: 24
          );
      },
    );
  }

  Future<void> alertBox(BuildContext context, String title, String message, Function onPressed ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext c) {
        return
          AlertDialog(
            backgroundColor: MyColors.boxGround,
              title: Align(
                alignment: Alignment.center,
                child: Text(title, style:MyStyles.headerStyle1),
              ),
              content: Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                child: Text(message, textAlign: TextAlign.center, style:MyStyles.headerStyle1.copyWith(fontSize:12, height:2)),
              ),
              actions: <Widget>[
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                //   child: MyPostButton(text: 'Okay', colorStyle:4, onPressed:(){ onPressed.call(); }),
                // ),
              ],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              elevation: 24
          );
      },
    );
  }

  saveAudioQuality(String key, List<String> value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, value);
  }

  Future<List<String>> getAudioQuality(String key) async
  {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? [];
  }

  mySaveState(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<String> getMySaveState(String key) async
  {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }

  mySaveStateDelete(String key) async
  {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  doLogout(BuildContext context) async{
    var filePath = await getSplashImageFilePath();
    getIt<SplashScreen>().filePath = filePath;
    getIt<SplashScreen>().action = 'logout';

    try {
      final loginSession = getIt<LoginSession>();
      final Response rs = await DoLogin().logout(loginSession.authToken);
      debugPrint(rs.message);
    }catch(e){
      debugPrint('Exception $e');
    }

    // await Common().mySaveStateDelete(CommonText.loginTokenKey);
    // await Common().mySaveStateDelete(CommonText.audioQuality);
    // await Common().mySaveStateDelete(CommonText.selectedAudioQuality);
    // await Common().mySaveStateDelete(CommonText.maxSessionKey);
    final pageManager = getIt<PageManager>();
    pageManager.appPageMessageNotifier.value = '';
    pageManager.appPageActionNotifier.value = AppAction.normal;

    Future.delayed(const Duration(milliseconds: 100),(){
      //Navigator.pushNamedAndRemoveUntil(context, Login.id,ModalRoute.withName('/'));
    });
  }

  static Future<String> getSplashImageFilePath() async {
    String filePath = await _getDownloadedSplashImageFilePath();
    File file = File(filePath);
    if (file.existsSync()) return filePath;
    final byteData = await rootBundle.load('lib/assets/images/default-splash.jpg');
    file.create(recursive: true);
    await file.writeAsBytes(byteData.buffer.asUint8List());
    return filePath;
  }

  static Future<String> _getDownloadedSplashImageFilePath() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String filePath = '$appDocPath/splash_image.jpg';
    return filePath;
  }
}