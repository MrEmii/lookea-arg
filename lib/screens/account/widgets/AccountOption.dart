import 'package:flutter/material.dart';
import 'package:lookea/widgets/LColors.dart';
import 'package:lookea/widgets/LIcons.dart';

class AccountOption extends StatelessWidget {

  final IconData icon;
  final String name;
  final Function onTap;
  Color color;

  AccountOption({Key key, this.icon, this.name, this.onTap, this.color = LColors.gray1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: this.onTap,
      color: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      elevation: 0,
      hoverElevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      splashColor: LColors.white19.withOpacity(0.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      textColor: LColors.black9,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 54,
              height: 54,
              margin: EdgeInsets.only(right: 20 ),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(15)
              ),
              child: Icon(this.icon, size: 24, color: Colors.white,),
            ),
            Expanded(child: Text(name)),
            Icon(LIcons.angle_right, color: Colors.black,)
          ],
        ),
      ),
    );
  }
}