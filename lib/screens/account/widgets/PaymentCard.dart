import 'package:flutter/material.dart';
import 'package:lookea/widgets/LColors.dart';

class PaymentCard extends StatelessWidget {

  String id;
  IconData icon;
  Function onTap;
  PaymentCard({this.id, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: LColors.gray6,
          borderRadius: BorderRadius.circular(13)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(this.id, style: TextStyle(fontSize: 14, color: LColors.black9),),
            Icon(this.icon, color: LColors.black9)
          ],
        ),
      ),
    );
  }
}