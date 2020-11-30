import 'package:flutter/material.dart';
import 'package:lookea/widgets/LColors.dart';

class HomeTab extends StatelessWidget {

  final Icon icon;
  final String text;
  final bool selected;

  const HomeTab({Key key, this.icon, this.text, this.selected = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: selected ? 1 : .6,
      child: Container(
        height: 60,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            this.icon,
            SizedBox(width: 5,),
            Text(text, style: TextStyle(fontSize: selected ? 18 : 14, fontWeight: FontWeight.w500, color: LColors.black9),)
          ],
        ),
      ),
    );
  }
}