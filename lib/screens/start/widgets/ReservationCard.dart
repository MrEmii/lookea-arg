import 'package:flutter/material.dart';
import 'package:lookea/widgets/LColors.dart';
import 'package:lookea/widgets/LIcons.dart';

class ReservationCard extends StatelessWidget {
  const ReservationCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: LColors.gray6,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            margin: EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: LColors.black9
            ),
            child: Icon(LIcons.scissors, size: 24,)
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Barbería las barbas", style: TextStyle(fontSize: 14),),
              Text("Lunes 24 de diciembre 16:00hrs", softWrap: true,),
              Text("Pagaste 200 pesos en efectivo"),
            ],
          )
        ],
      ),
    );
  }
}