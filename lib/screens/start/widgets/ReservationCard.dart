import 'package:flutter/material.dart';
import 'package:lookea/models/payment_model.dart';
import 'package:lookea/models/reservation_model.dart';
import 'package:lookea/providers/MainProvider.dart';
import 'package:lookea/screens/start/bottomsheets/ReservationSheet.dart';
import 'package:lookea/widgets/LColors.dart';
import 'package:lookea/widgets/LIcons.dart';
import 'package:intl/intl.dart';
import 'package:lookea/utils/extensions.dart';
class ReservationCard extends StatelessWidget {

  ReservationModel model;

  ReservationCard(this.model);

  @override
  Widget build(BuildContext context) {
    DateTime time = DateFormat("dd/MM/yyyy HH:mm").parse(model.dateTime);

    return GestureDetector(
      onTap: () => showModalBottomSheet(context: context, backgroundColor: Colors.transparent, builder: (_) => ReservationBottomSheet(model)),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: LColors.gray6,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
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
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(model.shopId.split("||")[1].capitalize(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff303037)),),
                Text("${MainProvider.days[time.weekday - 1]} ${time.day} de ${MainProvider.meses[time.month - 1]} ${format(Duration(hours: time.hour, minutes: time.minute))}", style: TextStyle(fontWeight: FontWeight.w500, color: LColors.gray3), softWrap: true,),
                Text("Pagaste ${model.price} pesos en ${PaymentType.values[model.methodPayment].toShortString().toLowerCase()}", style: TextStyle(fontWeight: FontWeight.w500, color: LColors.gray3),),
                Text("Toca para ver más", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: LColors.gray4)),
              ],
            )
          ],
        ),
      ),
    );
  }

  format(Duration d){
    List<String> s = d.toString().split(':')
                        ..removeAt(2);
    return s.join(":").padLeft(5, "0");
  }
}