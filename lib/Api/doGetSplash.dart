import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '../Classes/MyException.dart';
import '../Common/Common.dart';
import '../Common/CommonText.dart';
import '../Models/SplashScreen.dart';

class DoGetSplash
{
  late String filePath;
  Future<SplashScreen> call() async
  {
    try {
      var response = await http.get(Uri.parse('${CommonText.server}splash'),
          headers: {"Content-Type": "application/json"})
          .timeout(const Duration(seconds: CommonText.serverTimeOutInSeconds));

      Map<String, dynamic> data = json.decode(response.body);
      if(data['success']==null || data['data']==null)
      {
        throw(MyException('Invalid server response'));
      }

      if(response.statusCode==200)
      {
        if(data['success']){
          var _url = data['data'][0]['thumbnail'];

          var imgData = await http.get(Uri.parse(_url),
              headers: {"Content-Type": "image/jpeg"})
              .timeout(const Duration(seconds: CommonText.serverTimeOutInSeconds));
          var img = imgData.bodyBytes;

          Directory appDocDir = await getApplicationDocumentsDirectory();
          String appDocPath = appDocDir.path;
          filePath = '$appDocPath/splash_image.jpg';

          File f = File(filePath);
          f.writeAsBytesSync(img);
          return SplashScreen(id:data['data'][0]['id'] ?? 0, filePath: filePath, action: '', published: data['data'][0]['published'] ?? false);
        }else{
          return SplashScreen(id:0, filePath:'', action: '', published: false);
        }
      }else{
        return SplashScreen(id:0, filePath:'', action: '', published: false);
      }
    }
    on TimeoutException catch(_){
      throw MyException(CommonText.serverTimeOut);
    }
    on SocketException catch(_){
      filePath = await Common.getSplashImageFilePath();
      return SplashScreen(id:0, filePath:filePath, action: '', published: false);
    }
    on HttpException catch(a){
      throw MyException(a.message);
    }
    on Exception catch(b){
      throw MyException(b.toString());
    }
  }
}
