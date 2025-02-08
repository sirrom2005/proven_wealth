// import 'dart:io';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:firebase_core/firebase_core.dart';
// import '../firebase_options.text';
//
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   _exeMessage(message);
// }
//
// _exeMessage(RemoteMessage message){
//   // Handle background messages
//   print("Handling a background message: ${message.messageId}");
//   print(message.notification!.title);
//   print(message.notification!.body);
// }
//
// class FireBaseApi
// {
//   Future<void> setupFlutterNotifications() async {
//     await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//
//     if (Platform.isIOS) {
//       await Future.delayed(const Duration(seconds: 10));
//       final notificationSettings = await FirebaseMessaging.instance.requestPermission(provisional: true);
//       notificationSettings.alert;
//       String? token = await FirebaseMessaging.instance.getToken();
//       debugPrint('TOKEN >> ${token}');
//     }
//
//     FirebaseMessaging.instance.subscribeToTopic("ALLOW-COUNTRY");
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       _exeMessage(message);
//     });
//   }
// }