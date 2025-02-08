import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../Classes/AppAction.dart';
import '../Classes/MyException.dart';
import '../Common/CommonText.dart';
import '../Models/Permissions.dart';
import '../Models/Profile.dart';
import '../Models/Response.dart';
import '../Services/page_manager.dart';
import '../Services/service_locator.dart';

class DoGetProfile
{
  Future<Profile> call(String token) async
  {
    try {
      var response = await http.get(Uri.parse('${CommonText.server}profile'),
          headers: {"Content-Type": "application/json","Authorization": "Bearer $token"})
          .timeout(const Duration(seconds: CommonText.serverTimeOutInSeconds));

      var geoResponse = await http.get(Uri.parse('${CommonText.server}geofence'),
          headers: {"Content-Type": "application/json","Authorization": "Bearer $token"})
          .timeout(const Duration(seconds: CommonText.serverTimeOutInSeconds));

      bool isGeoEnabled = false;
      Map<String, dynamic> data = json.decode(geoResponse.body);
      if(geoResponse.statusCode==200){
        isGeoEnabled = data['is_enabled']==true ? true : false;
      }

      data = json.decode(response.body);
      if(data['success']==null || data['data']==null)
      {
        throw(MyException('Invalid server response'));
      }

      if(response.statusCode==200 && data['success'])
      {
        Map<String, dynamic> rs = data['data']['profile'];
        List<Permissions> myPermission = [];

        for (var T in data['data']['profile']['current_subscription']['permissions'] ?? []) {
          myPermission.add(Permissions(
              name:       T['permissable_model'] ?? '',
              canRead:    T['can_read']   ?? false,
              canCreate:  T['can_create'] ?? false,
              canEdit:    T['can_edit']   ?? false,
              canDelete:  T['can_delete'] ?? false,
              isGeoLocationEnabled: isGeoEnabled
          ));
        }

        return Profile(id:rs['id'] ?? 0, firstname:rs['firstname'] ?? '', lastname:rs['lastname'] ?? '', email:rs['email'] ?? '', mobile:rs['phone'] ?? '', permission:myPermission);
      }

      if(!data['success']){
        getIt<PageManager>().appPageMessageNotifier.value = data['flash']['error'];
        getIt<PageManager>().appPageActionNotifier.value = AppAction.logout;
        return Future.error('');
      }
      else{
        throw MyException(CommonText.errorResponse);
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

  Future<Response> update(String fname, String lname, String email, String phone, String token) async
  {
    Map data = {
      'profile': {
        'firstname': fname,
        'lastname': lname,
        'email': email,
        'phone': phone
      }
    };

    var body = json.encode(data);

    try {
      var response = await http.put(Uri.parse('${CommonText.server}profile'),
          headers: {"Content-Type": "application/json","Authorization": "Bearer $token"}, body: body)
          .timeout(const Duration(seconds: CommonText.serverTimeOutInSeconds));

      Map<String, dynamic> data = json.decode(response.body);
      if(data['success']==null || data['data']==null)
      {
        throw(MyException('Invalid server response'));
      }

      if(response.statusCode==200 && data['success'])
      {
        String message  = data['flash']['notice'];
        return Response(success: data['success'], message:message);
      }if(!data['success']){
        getIt<PageManager>().appPageMessageNotifier.value = data['flash']['error'];
        getIt<PageManager>().appPageActionNotifier.value = AppAction.logout;
        return Future.error('');
      }
      else{
        throw MyException(CommonText.errorResponse);
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

  Future<Response> updatePassword(String currentPassword, String password, String confirmation, String token) async
  {
    Map data = {
      'profile': {
        'current_password': currentPassword.trim(),
        'password': password.trim(),
        'password_confirmation': confirmation.trim()
      }
    };

    var body = json.encode(data);

    try {
      var response = await http.put(Uri.parse('${CommonText.server}profile'),
          headers: {"Content-Type": "application/json","Authorization": "Bearer $token"}, body: body)
          .timeout(const Duration(seconds: CommonText.serverTimeOutInSeconds));

      Map<String, dynamic> data = json.decode(response.body);

      if(response.statusCode==200 && data['success'])
      {
        String message = (data['success']) ? data['flash']['notice'] ?? '' : data['errors'][0] ?? '';
        return Response(success: data['success'], message:message);
      }if(!data['success']){
        return Response(success: false, message:data['flash']['error']);
      }
      else{
        throw MyException(CommonText.errorResponse);
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