import 'package:flutter/material.dart';
import 'package:lookea/models/notifications_model.dart';
import 'package:lookea/widgets/LColors.dart';
import 'package:lookea/widgets/LIcons.dart';

class NotificationItem extends StatelessWidget {

  NotificationsModel model;
  Function() onRemove;

  NotificationItem({this.model, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: ShapeDecoration(
        color: LColors.gray6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20))  ,
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(model.title, style: TextStyle(color: LColors.white26),),
              Text(model.description, style: TextStyle(color: LColors.gray3),)
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(icon: Icon(LIcons.times, color: LColors.white26,), onPressed: () => this.onRemove() ),
          ),
        ],
      ),
    );
  }
}