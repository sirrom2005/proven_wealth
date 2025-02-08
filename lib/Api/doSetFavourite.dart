import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../Classes/AppAction.dart';
import '../Classes/MyException.dart';
import '../Common/CommonText.dart';
import '../Models/Response.dart';
import '../Services/page_manager.dart';
import '../Services/service_locator.dart';

class DoSetFavourite
{
  Future<Response> addFavourite(int id, String token) async
  {
    try{
      var response = await http.post(Uri.parse('${CommonText.server}programs/$id/bookmark'),
          headers: {"Content-Type": "application/json","Authorization": "Bearer $token"})
          .timeout(const Duration(seconds: CommonText.serverTimeOutInSeconds));

      return await _favourite(response, token);
    }catch(_){
      rethrow;
    }
  }

  Future<Response> delFavourite(int id, String token) async
  {
    try{
      var response = await http.delete(Uri.parse('${CommonText.server}programs/$id/bookmark'),
          headers: {"Content-Type": "application/json","Authorization": "Bearer $token"})
          .timeout(const Duration(seconds: CommonText.serverTimeOutInSeconds));

      return await _favourite(response, token);
    }catch(_){
      rethrow;
    }
  }

  Future<Response> _favourite(http.Response response, String token) async
  {
    try {
      Map<String, dynamic> data = json.decode(response.body);
      if(data['success']==null || data['flash']==null)
      {
        throw(MyException('Invalid server response'));
      }

      if(response.statusCode==200)
      {
        if(data['success']==true){
          return Response(success: data['success'], message:data['flash']['notice'] ?? 'Unknown server error') ;
        }else{
          return Response(success: data['success'], message:data['errors'][0] ?? 'Unknown server error') ;
        }
      }else {
        getIt<PageManager>().appPageMessageNotifier.value = data['flash']['error'] ?? 'Unknown server error';
        getIt<PageManager>().appPageActionNotifier.value = AppAction.logout;
        return Future.error('');
      }
    }
    on TimeoutException catch(_){
      throw MyException(CommonText.serverTimeOut);
    }
    on SocketException catch(_){
      throw MyException(CommonText.serverError);
    }
    on HttpException catch(a){
      throw MyException(a.message);
    }
    on Exception catch(b){
      throw MyException(b.toString());
    }
  }
}
