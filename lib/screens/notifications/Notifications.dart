import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lookea/models/notifications_model.dart';
import 'package:lookea/providers/NotificationsProvider.dart';
import 'package:lookea/screens/notifications/widgets/NotificationItem.dart';
import 'package:lookea/widgets/LIcons.dart';
import 'package:provider/provider.dart';


class NotificationsScreen extends StatefulWidget {

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {

  @override
  void initState() {
    PushNotificationProvider notificationProvider = Provider.of<PushNotificationProvider>(context, listen: false);
    notificationProvider.notifications = List.generate(20, (index) => NotificationsModel(title: "Test $index", description: "Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera", id: "$index"));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PushNotificationProvider notificationProvider = Provider.of<PushNotificationProvider>(context);
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(LIcons.bell_slash),
            tooltip: "Eliminar notificaciones",
          )
        ],
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(LIcons.angle_left),
        ),
        centerTitle: true,
        title: Text("Notificaciones"),
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          Random r = Random();
          notificationProvider.notifications = List.generate(r.nextInt(10), (index) => NotificationsModel(title: "Test $index", description: "Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera", id: "$index"));
          notificationProvider.notify();
        },
        child: Container(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.vertical,
            itemCount: notificationProvider.notifications.length,
            itemBuilder: (_, index) {
              return NotificationItem(model:  notificationProvider.notifications[index], onRemove: () {
                print("REMOVE");
                  notificationProvider.notifications = List.from(notificationProvider.notifications)
                                                          ..removeAt(index);
                  notificationProvider.notify();
              },);
            },
          ),
        ),
      )
   );
  }
}