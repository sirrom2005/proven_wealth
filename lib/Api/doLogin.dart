import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../Classes/MyException.dart';
import '../Common/CommonText.dart';
import '../Models/LoginUser.dart';
import '../Models/Response.dart';

class DoLogin
{
  Future<LoginUser> call(String username, String password) async
  {
    Map data = {
      'session': {
        'login': username,
        'password': password
      }
    };

    var postBody = json.encode(data);

    try {
      var response = await http.post(Uri.parse('${CommonText.server}login'),
          headers: {"Content-Type": "application/json"}, body: postBody)
          .timeout(const Duration(seconds: CommonText.serverTimeOutInSeconds));

      Map<String, dynamic> data = json.decode(response.body);
      if(data['success']==null || data['data']==null)
      {
        throw(MyException('Invalid server response'));
      }

      if(response.statusCode==200)
      {
        if(data['success']){
          var _data = data['data']['record'];
          String loginSessionError = '';
          if(data['data']['errors']!=null){
            loginSessionError =  data['data']['errors'][0];
          }

          var rs = await http.get(Uri.parse('${CommonText.server}profile'),
              headers: {"Content-Type": "application/json", "Authorization": "Bearer ${_data['authToken'] ?? ''}"})
              .timeout(const Duration(seconds: CommonText.serverTimeOutInSeconds));

          Map<String, dynamic> rsData = json.decode(rs.body);

          if(rsData['data']==null)
          {
            throw(const HttpException('Invalid server response'));
          }

          var profileData = rsData['data']['profile'];
          String currentAudioQuality = '';
          List<String> audioQuality = [];
          int loginSession = _data['login_count'] ?? 0;
          int loginMaxSession = _data['active_sessions_count'] ?? 1;

          if(response.statusCode==200){
            if(profileData['current_subscription'] == null)
            {
              return LoginUser(id:-9999, name:'', email:'', authToken:'', lastLogin:'', message:'', audioQuality: []);
            }
            else if(loginSession > loginMaxSession)
            {
              loginSessionError = loginSessionError.isEmpty ? CommonText.maxSession : loginSessionError;
              return LoginUser(id:-9998, name:'', email:'', authToken:'', lastLogin:'', message:loginSessionError, audioQuality: []);
            }
            else
            {
              currentAudioQuality = profileData['current_audio_quality'] ?? '';
              for (var T in profileData['current_subscription']['audio_quality'] ?? []) {
                audioQuality.add(T);
              }
            }
          }else if(response.statusCode==500)
          {
            return LoginUser(id:0, name:'', email:'', authToken:'', lastLogin:'', message:rsData['error'] ?? '500 server error', audioQuality: []);
          }

          return LoginUser(id:_data['id'] ?? 0, name:_data['name'] ?? '', email:_data['email'] ?? '', authToken:_data['authToken'] ?? '', message:currentAudioQuality, lastLogin:_data['last_login_at'] ?? '', audioQuality: audioQuality, maxSession: loginMaxSession);
        }else{
          return LoginUser(id:0, name:'', email:'', authToken:'', lastLogin:'', message:data['flash']['error'] ?? 'Unknown server error', audioQuality: []);
        }
      }
      else if(response.statusCode==500)
      {
        return LoginUser(id:0, name:'', email:'', authToken:'', lastLogin:'', message:data['error'] ?? '500 server error', audioQuality: []);
      }else{
        return LoginUser(id:0, name:'', email:'', authToken:'', lastLogin:'', message:'Unknown Error', audioQuality: []);
      }
    }
    on TimeoutException catch(_){
      return LoginUser(id:0, name:'', email:'', authToken:'', lastLogin:'', message:CommonText.serverTimeOut, audioQuality: []);
    }
    on SocketException catch(_){
      return LoginUser(id:0, name:'', email:'', authToken:'', lastLogin:'', message:CommonText.serverError, audioQuality: []);
    }
    on HttpException catch(a){
      return LoginUser(id:0, name:'', email:'', authToken:'', lastLogin:'', message:a.message, audioQuality: []);
    }
    on Exception catch(b){
      return LoginUser(id:0, name:'', email:'', authToken:'', lastLogin:'', message:'Error when receiving network data', audioQuality: []);
    }
  }

  Future<Response> sendResetEmail(String email) async
  {
    Map data = {'user': {'login': email}};

    var _body = json.encode(data);

    try{
      var response = await http.post(Uri.parse('${CommonText.server}password'),
        headers: {"Content-Type": "application/json"}, body: _body)
        .timeout(const Duration(seconds: CommonText.serverTimeOutInSeconds));

      return await _response(response);
    }catch(_){
      rethrow;
    }
  }

  Future<Response> resetPassword(String email, String pin, String password) async
  {
    Map data = {
                  'user': {
                    'password': password,
                    'pin': pin,
                    'login': email
                  }
              };

    var _body = json.encode(data);

    try{
      var response = await http.put(Uri.parse('${CommonText.server}password'),
          headers: {"Content-Type": "application/json"}, body: _body)
          .timeout(const Duration(seconds: CommonText.serverTimeOutInSeconds));

      return await _response(response);
    }catch(_){
      rethrow;
    }
  }

  Future<Response> _response(http.Response response) async
  {
    try {
      Map<String, dynamic> data = json.decode(response.body);
      if(data['success']==null || data['flash']==null)
      {
        throw(const HttpException('Invalid server response'));
      }

      if(response.statusCode==200)
      {
        if(data['success']){
          return Response(message:data['flash']['notice'], success: true);
        }else{
          return Response(message:data['flash']['error'], success: false);
        }
      }else if(response.statusCode==500){
        return Response(message:data['error'] ?? '500 server error', success: false);
      }else{
        return Response(message:'Unknown Error', success: false);
      }
    }
    on TimeoutException catch(_){
      return Response(message:CommonText.serverTimeOut, success: false);
    }
    on SocketException catch(_){
      return Response(message:CommonText.serverError, success: false);
    }
    on HttpException catch(a){
      return Response(message:a.message, success: false);
    }
    on Exception catch(b){
      return Response(message:b.toString(), success: false);
    }
  }

  Future<Response> logout(String token) async
  {
    try{
      var response = await http.delete(Uri.parse('${CommonText.server}logout'),
          headers: {"Content-Type": "application/json","Authorization": "Bearer $token"})
          .timeout(const Duration(seconds: CommonText.serverTimeOutInSeconds));

      Map<String, dynamic> data = json.decode(response.body);
      if(data['success']==null || data['flash']==null)
      {
        throw(MyException('Invalid server response'));
      }

      if(response.statusCode==200)
      {
        if(data['success']){
          return Response(message:data['flash']['notice'], success: true);
        }else{
          return Response(message:data['flash']['error'], success: false);
        }
      }else if(response.statusCode==500){
        return Response(message:data['error'] ?? '500 server error', success: false);
      }else{
        return Response(message:'Unknown Error', success: false);
      }
    }
    on TimeoutException catch(_){
      return Response(message:CommonText.serverTimeOut, success: false);
    }
    on SocketException catch(_){
      return Response(message:CommonText.serverError, success: false);
    }
    on HttpException catch(a){
      return Response(message:a.message, success: false);
    }
    on Exception catch(b){
      return Response(message:b.toString(), success: false);
    }
  }
}
