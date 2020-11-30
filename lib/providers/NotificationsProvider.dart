import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:lookea/models/notifications_model.dart';

class PushNotificationProvider extends ChangeNotifier{

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  List<NotificationsModel> notifications;

  initNotifications() async{
    _firebaseMessaging.requestNotificationPermissions();

    var token = await _firebaseMessaging.getToken();

    print("==== FCM ====");
    print(token);

    //eaTcR-g2S-ORv_uKdDFRLn:APA91bGvfh83GtiZbX4NmhimD1BWUMyPa1doGBdrx6oUo-fnDLrZuNNAGkusoLcgbwneaAWAv43098cTXUt3kL4dMTmGL03hsi31m_5v35FOffIu1aBcpAhA-2DCDWRsR6zg7YYhoo8C


    _firebaseMessaging.configure(
      onMessage: (message) {
        print("================ On Message ================");
        print(message);
      },
      onLaunch: (message) {
        print("================ On Launch ================");
        print(message);
      },
      onResume: (message) {
        print("================ On Resume ================");
        print(message);
      },
    );
  }

  void notify(){
    this.notifyListeners();
  }


}